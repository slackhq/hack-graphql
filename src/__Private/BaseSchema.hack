namespace Slack\GraphQL\__Private;

// TODO: this should be private
abstract class BaseSchema {
    abstract public static function resolveQuery(
        \Graphpinator\Parser\Operation\Operation $operation,
        Variables $variables,
    ): Awaitable<mixed>;

    public static async function resolveField<TGraphQLType as Types\ObjectType, THackType>(
        \Graphpinator\Parser\Field\Field $field,
        TGraphQLType $parent_type,
        THackType $parent,
        Variables $variables,
    ): Awaitable<mixed> where THackType = TGraphQLType::THackType {
        $field_name = $field->getName();
        $field_type = $parent_type::resolveType($field_name);

        invariant($field_type is Types\NamedOutputType, 'TODO: List support');

        // assertValidValue enforces that resolveType and resolveField are consistent for $field_name.
        $field_value = $field_type->assertValidValue(
            await $parent_type::resolveField($field_name, $parent, $field->getArguments() ?? dict[], $variables),
        );

        if (!$field_type is Types\ObjectType) {
            return $field_value;
        }

        // TODO: If field_type is ListType, iterate over the children calling resolveField?

        $child_data = dict[];
        foreach ($field->getFields()?->getFields() ?? vec[] as $child_field) {
            $child_data[$child_field->getName()] = await self::resolveField(
                $child_field,
                $field_type,
                $field_value,
                $variables,
            );
        }
        return $child_data;
    }
}
