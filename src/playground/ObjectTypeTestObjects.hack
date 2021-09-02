


use namespace Slack\GraphQL;


abstract final class ObjectTypeTestEntrypoint {
    <<GraphQL\QueryRootField('getObjectShape', 'fetch an object shape')>>
    public static function getObjectShape(): ObjectShape {
        return shape(
            'foo' => 3,
            'baz' => shape(
                'abc' => vec[1, 2, 3],
            ),
        );
    }
}


<<GraphQL\ObjectType('ObjectShape', 'ObjectShape')>>
type ObjectShape = shape(
    'foo' => int,
    ?'bar' => string,
    'baz' => AnotherObjectShape,
);


<<GraphQL\ObjectType('AnotherObjectShape', 'AnotherObjectShape')>>
type AnotherObjectShape = shape(
    'abc' => vec<int>,
);
