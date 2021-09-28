


namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Str, Vec};
use type Facebook\DefinitionFinder\ScannedMethod;

final class DirectivesFinder {
    public function __construct(
        private shape(
            ?'fields' => vec<classname<\Slack\GraphQL\FieldDirective>>,
            ?'objects' => vec<classname<\Slack\GraphQL\ObjectDirective>>,
        ) $directives,
    ) {}

    public async function findDirectivesForField(\ReflectionMethod $rm): Awaitable<dict<string, vec<string>>> {
        $directives = dict[];

        $custom_directive_types = $this->directives['fields'] ?? vec[];
        foreach ($custom_directive_types as $directive_type) {
            $directive = $rm->getAttributeClass($directive_type);
            if ($directive is nonnull) {
                $rc = new \ReflectionClass($directive);
                $constructor = $rc->getMethod('__construct');
                $arguments = vec[];
                if ($constructor) {
                    $parameters = $constructor->getParameters();
                    foreach ($parameters as $parameter) {
                        $value = $rc->getProperty($parameter->getName());
                        $value->setAccessible(true);
                        $arguments[] = \var_export($value->getValue($directive), true)
                            |> Str\replace($$, 'darray', 'dict')
                            |> Str\replace($$, 'varray', 'vec')
                            |> Str\replace($$, 'array', 'shape')
                            |> Str\replace($$, 'dict ', 'dict')
                            |> Str\replace($$, 'vec ', 'vec')
                            |> Str\replace($$, 'shape ', 'shape');
                    }
                }
                $directives[$rc->getName()] = $arguments;
            }
        }

        return $directives;
    }
}
