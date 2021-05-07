namespace Slack\GraphQL;

use namespace Facebook\TypeAssert;

// TODO: this should be private
abstract class BaseSchema {
    abstract public static function resolveQuery(\Graphpinator\Parser\Operation\Operation $operation): Awaitable<mixed>;

    public static async function resolveField<TGraphQLType as \Slack\GraphQL\Types\ObjectType, THackType>(
        \Graphpinator\Parser\Field\Field $field,
        TGraphQLType $parent_type,
        THackType $parent,
    ): Awaitable<mixed> where THackType = TGraphQLType::THackType {
        $field_name = $field->getName();
        $field_type = $parent_type::resolveType($field_name);

        // This TypeAssert enforces that resolveType and resolveField are
        // consistent for $field_name.
        $field_value = TypeAssert\matches_type_structure(
            \HH\type_structure($field_type, 'THackType'),
            await $parent_type::resolveField($field_name, $parent),
        );

        if (!$field_type is \Slack\GraphQL\Types\ObjectType) {
            return $field_value;
        }

        $child_data = dict[];
        foreach (($field->getFields() as nonnull)->getFields() as $child_field) { // TODO: ->getFragments()
            $child_data[$child_field->getName()] = await self::resolveField($child_field, $field_type, $field_value);
        }
        return $child_data;
    }
}
