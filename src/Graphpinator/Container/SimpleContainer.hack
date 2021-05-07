namespace Graphpinator\Container;

use namespace HH\Lib\Dict;

/**
 * Simple Container implementation
 */
class SimpleContainer extends \Graphpinator\Container\Container {
    protected dict<string, \Graphpinator\Type\Contract\NamedDefinition> $types = dict[];
    protected dict<string, \Graphpinator\Directive\Directive> $directives = dict[];
    protected dict<string, \Graphpinator\Type\Contract\NamedDefinition> $combinedTypes = dict[];
    protected dict<string, \Graphpinator\Directive\Directive> $combinedDirectives = dict[];

    /**
     * @phpcs:ignore SlevomatCodingStandard.TypeHints.DisallowArrayTypeHintSyntax.DisallowedArrayTypeHintSyntax
     * @param \Graphpinator\Type\Contract\NamedDefinition[] $types
     * @phpcs:ignore SlevomatCodingStandard.TypeHints.DisallowArrayTypeHintSyntax.DisallowedArrayTypeHintSyntax
     * @param \Graphpinator\Directive\Directive[] $directives
     */
    public function __construct(
        vec<\Graphpinator\Type\Contract\NamedDefinition> $types,
        vec<\Graphpinator\Directive\Directive> $directives,
    ) {
        self::$builtInTypes = dict[
            'ID' => self::ID(),
            'Int' => self::Int(),
            'Float' => self::Float(),
            'String' => self::String(),
            'Boolean' => self::Boolean(),
            '__Schema' => new \Graphpinator\Introspection\Schema($this),
            '__Type' => new \Graphpinator\Introspection\Type($this),
            '__TypeKind' => new \Graphpinator\Introspection\TypeKind(),
            '__Field' => new \Graphpinator\Introspection\Field($this),
            '__EnumValue' => new \Graphpinator\Introspection\EnumValue(),
            '__InputValue' => new \Graphpinator\Introspection\InputValue($this),
            '__Directive' => new \Graphpinator\Introspection\Directive($this),
            '__DirectiveLocation' => new \Graphpinator\Introspection\DirectiveLocation(),
        ];
        self::$builtInDirectives = dict[
            'skip' => self::directiveSkip(),
            'include' => self::directiveInclude(),
            'deprecated' => self::directiveDeprecated(),
        ];

        foreach ($types as $type) {
            $this->types[$type->getName()] = $type;
        }

        foreach ($directives as $directive) {
            $this->directives[$directive->getName()] = $directive;
        }

        $this->combinedTypes = Dict\merge($this->types, self::$builtInTypes);
        $this->combinedDirectives = Dict\merge($this->directives, self::$builtInDirectives);
    }

    public function getType(string $name): ?\Graphpinator\Type\Contract\NamedDefinition {
        return $this->combinedTypes[$name] ?? null;
    }

    public function getTypes(bool $includeBuiltIn = false): dict<string, \Graphpinator\Type\Contract\NamedDefinition> {
        return $includeBuiltIn ? $this->combinedTypes : $this->types;
    }

    public function getDirective(string $name): ?\Graphpinator\Directive\Directive {
        return $this->combinedDirectives[$name] ?? null;
    }

    public function getDirectives(bool $includeBuiltIn = false): dict<string, \Graphpinator\Directive\Directive> {
        return $includeBuiltIn ? $this->combinedDirectives : $this->directives;
    }
}
