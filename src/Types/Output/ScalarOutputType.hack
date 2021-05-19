namespace Slack\GraphQL\Types;

use namespace Slack\GraphQL\Introspection;

abstract class ScalarOutputType extends LeafOutputType {

    <<__Override>>
    final public static function introspect(Introspection\__Schema $_): Introspection\NamedTypeDeclaration {
        return new Introspection\NamedTypeDeclaration(shape(
            'name' => static::NAME,
            'kind' => Introspection\__TypeKind::SCALAR,
        ));
    }
}
