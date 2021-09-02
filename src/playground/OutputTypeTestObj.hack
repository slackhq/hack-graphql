
use namespace Slack\GraphQL;

<<GraphQL\ObjectType('OutputShape', 'OutputShape')>>
type TOutputShape = shape(
    'string' => string,
    'vec_of_int' => vec<int>,
    'nested_shape' => TOutputNestedShape,
);

<<GraphQL\ObjectType('NestedOutputShape', 'NestedOutputShape')>>
type TOutputNestedShape = shape(
    'vec_of_string' => vec<string>,
);

<<GraphQL\ObjectType('OutputTypeTestObj', 'Test object for fields with various return types')>>
final class OutputTypeTestObj {

    <<GraphQL\QueryRootField('output_type_test', 'Root field to get an instance')>>
    public static function get(): OutputTypeTestObj {
        return new self();
    }

    <<GraphQL\Field(
        'scalar',
        'Note that the GraphQL field will be nullable by default, despite its non-nullable Hack type',
    )>>
    public function scalar(): int {
        return 42;
    }

    <<GraphQL\Field('nullable', '')>>
    public function nullable(): ?string {
        return null;
    }

    <<GraphQL\Field('awaitable', '')>>
    public async function awaitable(): Awaitable<int> {
        return 42;
    }

    <<GraphQL\Field('awaitable_nullable', '')>>
    public async function awaitable_nullable(): Awaitable<?string> {
        return null;
    }

    <<GraphQL\Field('list', '')>>
    public function list(): vec<string> {
        return vec['forty', 'two'];
    }

    <<GraphQL\Field('awaitable_nullable_list', '')>>
    public async function awaitable_nullable_list(): Awaitable<?vec<int>> {
        return null;
    }

    <<GraphQL\Field('nested_lists', 'Note that nested lists can be non-nullable')>>
    public function nested_lists(): vec<?vec<vec<?int>>> {
        return vec[
            vec[vec[null, 42]],
            null,
            vec[vec[42], vec[null]],
        ];
    }

    <<GraphQL\Field('output_shape', '')>>
    public function output_shape(): TOutputShape {
        return shape(
            'string' => 'test',
            'vec_of_int' => vec[1, 2, 3],
            'nested_shape' => shape('vec_of_string' => vec['test', 'strings']),
        );
    }
}
