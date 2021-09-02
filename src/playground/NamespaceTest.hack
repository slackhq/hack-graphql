
namespace Foo;

<<\Slack\GraphQL\InterfaceType('FooInterface', 'Foo Interface')>>
abstract class FooInterface {}

<<\Slack\GraphQL\ObjectType('FooObject', 'Foo Object')>>
final class FooObject extends FooInterface {}
