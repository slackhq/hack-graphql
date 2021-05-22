use namespace Slack\GraphQL;

<<GraphQL\InterfaceType('IIntrospectionInterfaceA', 'IIntrospectionInterfaceA')>>
interface IIntrospectionInterfaceA {}

<<GraphQL\InterfaceType('IIntrospectionInterfaceB', 'IIntrospectionInterfaceB')>>
interface IIntrospectionInterfaceB extends IIntrospectionInterfaceA {}

<<GraphQL\InterfaceType('IIntrospectionInterfaceC', 'IIntrospectionInterfaceC')>>
interface IIntrospectionInterfaceC extends IIntrospectionInterfaceB {}

<<GraphQL\ObjectType('ImplementInterfaceA', 'ImplementInterfaceA')>>
final class ImplementInterfaceA implements IIntrospectionInterfaceA {}

<<GraphQL\ObjectType('ImplementInterfaceB', 'ImplementInterfaceB')>>
final class ImplementInterfaceB implements IIntrospectionInterfaceB {}

<<GraphQL\ObjectType('ImplementInterfaceC', 'ImplementInterfaceC')>>
final class ImplementInterfaceC implements IIntrospectionInterfaceB, IIntrospectionInterfaceC {}

<<GraphQL\ObjectType('IntrospectionTestObject', 'Test object for introspection')>>
final class IntrospectionTestObject {

    // TODO should support returning `this`
    <<GraphQL\QueryRootField('introspection_test', 'Root field to get an instance')>>
    public static function get(): IntrospectionTestObject {
        return new self();
    }

    <<GraphQL\Field('non_null_string', 'Non nullable string'), GraphQL\KillsParentOnException>>
    public function getNonNullString(): string {
        return 'non-null';
    }

    <<GraphQL\Field('default_nullable_string', 'Default nullable string')>>
    public function getDefaultNullableString(): string {
        return 'default';
    }

    <<GraphQL\Field('nullable_string', 'Nullable string')>>
    public function getNullableString(): ?string {
        return null;
    }

    <<GraphQL\Field('non_null_int', 'Nullable string'), GraphQL\KillsParentOnException>>
    public function getNonNullInt(): int {
        return 1;
    }

    <<GraphQL\Field('non_null_list_of_non_null', 'Non nullable list of non nullables'), GraphQL\KillsParentOnException>>
    public function getNonNullListOfNonNull(): vec<int> {
        return vec[1];
    }

    <<GraphQL\Field('default_list_of_non_nullable_int', 'Default list of non nullable int')>>
    public function getDefaultListOfNonNullableInt(): vec<int> {
        return vec[1];
    }

    <<GraphQL\Field('default_list_of_nullable_int', 'Default list of nullable int')>>
    public function getDefaultListOfNullableInt(): vec<?int> {
        return vec[null];
    }

}
