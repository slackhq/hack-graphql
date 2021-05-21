namespace Slack\GraphQL;

use namespace HH\Lib\C;
use namespace Slack\GraphQL;

use type Graphpinator\Parser\Fragment\Fragment;

final class ExecutionContext {

    public function __construct(
        private dict<string, mixed> $coercedVariableValues,
        private dict<string, Fragment> $fragmentDeclarations,
    ) {}

    public function getVariableValues(): dict<string, mixed> {
        return $this->coercedVariableValues;
    }

    public function getFragment(string $name): Fragment {
        GraphQL\assert(
            C\contains_key($this->fragmentDeclarations, $name),
            'Unknown fragment "%s"',
            $name,
        );
        return $this->fragmentDeclarations[$name];
    }
}
