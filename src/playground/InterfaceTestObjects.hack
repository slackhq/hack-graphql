
use namespace Slack\GraphQL;

<<GraphQL\InterfaceType('InterfaceA', 'InterfaceA')>>
interface InterfaceA {

    <<GraphQL\Field('foo', 'foo')>>
    public function foo(): string;
}

<<GraphQL\InterfaceType('InterfaceB', 'InterfaceB')>>
interface InterfaceB extends InterfaceA {

    <<GraphQL\Field('bar', 'bar')>>
    public function bar(): string;
}

<<GraphQL\ObjectType('Concrete', 'Concrete')>>
final class Concrete implements InterfaceB {

    <<GraphQL\QueryRootField('getConcrete', 'Root field to get an instance of Concrete')>>
    public static function getConcrete(): Concrete {
        return new self();
    }

    <<GraphQL\QueryRootField('getInterfaceA', 'Root field to get an instance of InterfaceA')>>
    public static function getInterfaceA(): InterfaceA {
        return new self();
    }

    <<GraphQL\QueryRootField('getInterfaceB', 'Root field to get an instance of InterfaceB')>>
    public static function getInterfaceB(): InterfaceB {
        return new self();
    }

    public function foo(): string {
        return 'foo';
    }

    <<GraphQL\Field('bar', 'bar')>>
    public function bar(): string {
        return 'bar';
    }

    <<GraphQL\Field('baz', 'baz')>>
    public function baz(): string {
        return 'baz';
    }
}
