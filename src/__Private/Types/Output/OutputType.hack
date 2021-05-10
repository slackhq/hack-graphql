namespace Slack\GraphQL\__Private\Types;

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

    /**
     * Use these to get a singleton list type instance wrapping this type.
     */
    <<__Memoize>>
    public function nonNullableListOf(): ListOutputType<this> {
        return new ListOutputType($this, false);
    }

    <<__Memoize>>
    public function nullableListOf(): ListOutputType<this> {
        return new ListOutputType($this, true);
    }

    // abstract public function accept(OutputTypeVisitor $visitor): mixed;
}
