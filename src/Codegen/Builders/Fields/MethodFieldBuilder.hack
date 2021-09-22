


namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Str, Vec};
use type Facebook\HackCodegen\{HackBuilder, HackBuilderValues};

/**
 * Represents a parameter on a GQL field.
 */
type Parameter = shape(
    'name' => string,
    'type' => string,
    'is_optional' => bool,
    ?'default_value' => string,
);

/**
 * Build a GQL field which resolves to a Hack method.
 *
 * In general, you will use `FieldBuilder::fromReflectionMethod` to obtain a `MethodFieldBuilder`. However, in rare
 * cases you will not have a `ReflectionMethod` available; when this occurs, you can instantiate `MethodFieldBuilder`
 * directly.
 *
 * When do we need to build methods which don't have corresponding reflection methods? The example I've found so far
 * is when the method we'd want to reflect on is generic. PHP doesn't support generics, so this would fail. Instead,
 * we can tell `MethodFieldBuilder` exactly what we want, and the runtime will successfully resolve the generic method.
 */
class MethodFieldBuilder extends FieldBuilder {
    <<__Override>>
    protected function generateResolverBody(HackBuilder $hb): void {
        if ($this->data['deprecation_reason'] ?? null) {
            $hb->add('/* HH_FIXME[4128] Deprecated */ ');
        }
        $type_info = $this->data['output_type'];
        $method_name = Shapes::at($this->data, 'method_name');
        $hb->addf(
            '%s%s%s(',
            ($type_info['needs_await'] ?? false) ? 'await ' : '',
            $this->getMethodCallPrefix(),
            $method_name,
        );

        $this->generateParametersInvocation($hb);

        $hb->add(')');
    }

    protected function generateParametersInvocation(HackBuilder $hb): void {
        $parameters = $this->data['parameters'] ?? vec[];
        if (!C\is_empty($parameters)) {
            $hb->newLine()->indent();
            foreach ($parameters as $param) {
                $arg = $this->getArgumentInvocationString($param);
                $hb->addLinef('%s,', $arg);
            }
            $hb->unindent();
        }
    }

    <<__Override>>
    protected function getArgumentDefinitions(): vec<Parameter> {
        return $this->data['parameters'] ?? vec[];
    }

    protected function getMethodCallPrefix(): string {
        $root_field_for_type = $this->data['root_field_for_type'] ?? null;
        if ($root_field_for_type is nonnull) {
            return '\\'.$root_field_for_type.'::';
        }
        return Str\format('$parent%s', ($this->data['is_static'] ?? false) ? '::' : '->');
    }

    final protected function getArgumentInvocationString(Parameter $param): string {
        return Str\format(
            '%s->coerce%sNamedNode(%s, $args, $vars%s)',
            input_type($param['type']),
            $param['is_optional'] ? 'Optional' : '',
            \var_export($param['name'], true),
            Shapes::keyExists($param, 'default_value') ? ', '.$param['default_value'] : '',
        );
    }
}
