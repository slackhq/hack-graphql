namespace Slack\GraphQL;

use namespace Facebook\TypeAssert;

// TODO: this should be private
abstract class BaseSchema {
    abstract public static function resolveQuery(
        \Graphpinator\Parser\Operation\Operation $operation,
        __Private\Variables $variables,
    ): Awaitable<mixed>;

    public static async function resolveField<TGraphQLType as \Slack\GraphQL\Types\ObjectType, THackType>(
        \Graphpinator\Parser\Field\Field $field,
        TGraphQLType $parent_type,
        THackType $parent,
        __Private\Variables $variables,
    ): Awaitable<mixed> where THackType = TGraphQLType::THackType {
        $field_name = $field->getName();
        $field_type = $parent_type::resolveType($field_name);

        $field_args = vec[];
        foreach ($field->getArguments() ?? vec[] as $field_arg) {
            $value_type = $field_arg->getValue();

            if ($value_type is \Graphpinator\Parser\Value\VariableRef) {
                $value = $variables[$value_type->getVarName()];
            } else {
                $value = $field_arg->getValue()->getRawValue();
            }

            $field_args[] = new __Private\Argument($value);
        }

        // This TypeAssert enforces that resolveType and resolveField are
        // consistent for $field_name.
        $field_value = TypeAssert\matches_type_structure(
            \HH\type_structure($field_type, 'THackType'),
            await $parent_type::resolveField($field_name, $parent, $field_args),
        );

        if (!$field_type is \Slack\GraphQL\Types\ObjectType) {
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
