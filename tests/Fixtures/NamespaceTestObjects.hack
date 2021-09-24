


namespace Foo {
    use namespace Slack\GraphQL;

    <<\Slack\GraphQL\InterfaceType('FooInterface', 'Foo Interface')>>
    abstract class FooInterface {}

    <<\Slack\GraphQL\ObjectType('FooObject', 'Foo Object')>>
    final class FooObject extends FooInterface {

        <<\Slack\GraphQL\Field('value', 'Value of the obj')>>
        public function getValue(): string {
            return 'bar';
        }
    }

    final class FooConnection extends GraphQL\Pagination\Connection {
        const type TNode = FooObject;

        protected async function fetch(
            GraphQL\Pagination\PaginationArgs $args,
        ): Awaitable<vec<GraphQL\Pagination\Edge<FooObject>>> {
            return vec[new GraphQL\Pagination\Edge(new FooObject(), $this->encodeCursor((string)0))];
        }
    }
}

namespace Foo\Bar {
    <<\Slack\GraphQL\ObjectType('Baz', 'Baz Object')>>
    final class Baz {
        <<\Slack\GraphQL\Field('value', 'Value of the obj')>>
        public function getValue(): string {
            return 'qux';
        }
    }
}
