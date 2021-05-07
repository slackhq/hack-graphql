namespace Slack\GraphQL\Types;

/**
 * GraphQL type that may be used for fields.
 * Includes scalar types, enums, object types, interfaces, and union types.
 *
 * @see https://spec.graphql.org/draft/#sec-Input-and-Output-Types
 */
abstract class OutputType extends BaseType {

    protected function __construct(private bool $nullable) {}

    final public function isNullable(): bool {
        return $this->isNullable();
    }

    // abstract public function accept(OutputTypeVisitor $visitor): mixed;
}
