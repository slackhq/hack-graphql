


namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Str, Vec};
use type Facebook\HackCodegen\{HackBuilder, HackBuilderValues};

/**
 * A special-case field builder which handles creating GraphQL fields which return connections.
 * Since connections accept arguments which are not passed into the user-defined method, we need
 * to set these arguments on the connection after calling the user-defined method. This is a hack.
 */
final class ConnectionFieldBuilder extends MethodFieldBuilder {
    <<__Override>>
    protected function generateResolverBody(HackBuilder $hb): void {
        $needs_await = $this->data['output_type']['needs_await'] ?? false;
        if ($needs_await) {
            // Wrap the async function call in parenthesis so we can chain off the return value.
            $hb->add('(');
        }
        parent::generateResolverBody($hb);
        if ($needs_await) {
            $hb->add(')');
        }
        $hb->addLine('->setPaginationArgs(')->indent();
        foreach ($this->getConnectionParameters() as $param) {
            $hb->addLinef('%s,', $this->getArgumentInvocationString($param));
        }
        $hb->unindent()->add(')');
    }

    <<__Override>>
    protected function getArgumentDefinitions(): vec<Parameter> {
        return Vec\concat($this->data['parameters'], $this->getConnectionParameters());
    }

    /**
     * Arguments set on the connection after it's been returned from the user-defined method.
     */
    protected function getConnectionParameters(): vec<Parameter> {
        return vec[
            shape(
                'name' => 'after',
                'type' => '?HH\string',
                'is_optional' => true,
                'default_value' => 'null',
            ),
            shape(
                'name' => 'before',
                'type' => '?HH\string',
                'is_optional' => true,
                'default_value' => 'null',
            ),
            shape(
                'name' => 'first',
                'type' => '?HH\int',
                'is_optional' => true,
                'default_value' => 'null',
            ),
            shape(
                'name' => 'last',
                'type' => '?HH\int',
                'is_optional' => true,
                'default_value' => 'null',
            ),
        ];
    }
}
