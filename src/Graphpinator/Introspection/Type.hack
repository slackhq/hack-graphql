namespace Graphpinator\Introspection;

use \Graphpinator\Type\Contract\Definition;

final class Type extends \Graphpinator\Type\Type<Definition> {
    const NAME = '__Type';
    const DESCRIPTION = 'Built-in introspection type.';

    public function __construct(private \Graphpinator\Container\Container $container) {
        parent::__construct();
    }

    public function validateNonNullValue(mixed $rawValue): bool {
        return $rawValue is Definition;
    }

    protected function getFieldDefinition(): \Graphpinator\Field\ResolvableFieldSet<Definition> {
        return new \Graphpinator\Field\ResolvableFieldSet(dict[
            'kind' => \Graphpinator\Field\ResolvableField::create(
                'kind',
                $this->container->getType('__TypeKind')?->notNull() as nonnull,
                static function(Definition $definition): mixed {
                    return $definition->accept(new TypeKindVisitor());
                },
            ),
            'name' => \Graphpinator\Field\ResolvableField::create(
                'name',
                \Graphpinator\Container\Container::String(),
                static function(Definition $definition): ?string {
                    return $definition is \Graphpinator\Type\Contract\NamedDefinition ? $definition->getName() : null;
                },
            ),
            'description' => \Graphpinator\Field\ResolvableField::create(
                'description',
                \Graphpinator\Container\Container::String(),
                static function(Definition $definition): ?string {
                    return $definition is \Graphpinator\Type\Contract\NamedDefinition
                        ? $definition->getDescription()
                        : null;
                },
            ),
            'fields' => \Graphpinator\Field\ResolvableField::create(
                'fields',
                $this->container->getType('__Field')?->notNull()?->list() as nonnull,
                static function(Definition $definition): ?\Graphpinator\Field\FieldSet {
                    if (!$definition is \Graphpinator\Type\Contract\InterfaceImplementor) {
                        return null;
                    }

                    if ($includeDeprecated === true) {
                        return $definition->getFields();
                    }

                    $filtered = dict[];

                    foreach ($definition->getFields() as $field) {
                        if ($field->isDeprecated()) {
                            continue;
                        }

                        $filtered[$field->getName()] = $field;
                    }

                    return new \Graphpinator\Field\FieldSet($filtered);
                },
            )->setArguments(new \Graphpinator\Argument\ArgumentSet(dict[
                'includeDeprecated' => \Graphpinator\Argument\Argument::create(
                    'includeDeprecated',
                    \Graphpinator\Container\Container::Boolean()->notNull(),
                )
                    ->setDefaultValue(false),
            ])),
            'interfaces' => \Graphpinator\Field\ResolvableField::create(
                'interfaces',
                $this->notNull()->list(),
                static function(Definition $definition): ?\Graphpinator\Type\InterfaceSet {
                    return $definition is \Graphpinator\Type\Contract\InterfaceImplementor
                        ? self::recursiveGetInterfaces($definition->getInterfaces())
                        : null;
                },
            ),
            'possibleTypes' => \Graphpinator\Field\ResolvableField::create(
                'possibleTypes',
                $this->notNull()->list(),
                function(Definition $definition): ?\Graphpinator\Type\TypeSet {
                    if ($definition is \Graphpinator\Type\UnionType) {
                        return $definition->getTypes();
                    }

                    if ($definition is \Graphpinator\Type\InterfaceType) {
                        $subTypes = vec[];

                        foreach ($this->container->getTypes() as $type) {
                            if ($type is \Graphpinator\Type\Type && $type->isInstanceOf($definition)) {
                                $subTypes[] = $type;
                            }
                        }

                        return new \Graphpinator\Type\TypeSet($subTypes);
                    }

                    return null;
                },
            ),
            'enumValues' => \Graphpinator\Field\ResolvableField::create(
                'enumValues',
                $this->container->getType('__EnumValue')?->notNull()?->list() as nonnull,
                static function(Definition $definition, ?bool $includeDeprecated): ?\Graphpinator\EnumItem\EnumItemSet {
                    if (!$definition is \Graphpinator\Type\EnumType) {
                        return null;
                    }

                    if ($includeDeprecated === true) {
                        return $definition->getItems();
                    }

                    $filtered = vec[];

                    foreach ($definition->getItems() as $enumItem) {
                        if ($enumItem->isDeprecated()) {
                            continue;
                        }

                        $filtered[] = $enumItem;
                    }

                    return new \Graphpinator\EnumItem\EnumItemSet($filtered);
                },
            )->setArguments(new \Graphpinator\Argument\ArgumentSet(dict[
                'includeDeprecated' => \Graphpinator\Argument\Argument::create(
                    'includeDeprecated',
                    \Graphpinator\Container\Container::Boolean()->notNull(),
                )
                    ->setDefaultValue(false),
            ])),
            'inputFields' => \Graphpinator\Field\ResolvableField::create(
                'inputFields',
                $this->container->getType('__InputValue')?->notNull()?->list() as nonnull,
                static function(Definition $definition, ?bool $_): ?\Graphpinator\Argument\ArgumentSet {
                    return $definition is \Graphpinator\Type\InputType ? $definition->getArguments() : null;
                },
            ),
            'ofType' => \Graphpinator\Field\ResolvableField::create(
                'ofType',
                $this,
                static function(Definition $definition, ?bool $_): ?Definition {
                    return $definition is \Graphpinator\Type\Contract\ModifierDefinition
                        ? $definition->getInnerType()
                        : null;
                },
            ),
        ]);
    }

    private static function recursiveGetInterfaces(
        \Graphpinator\Type\InterfaceSet $implements,
    ): \Graphpinator\Type\InterfaceSet {
        $return = new \Graphpinator\Type\InterfaceSet();

        foreach ($implements as $interface) {
            $return->merge(self::recursiveGetInterfaces($interface->getInterfaces()));
            $return->offsetSet($interface->getName(), $interface);
        }

        return $return;
    }
}
