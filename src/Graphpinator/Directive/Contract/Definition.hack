namespace Graphpinator\Directive\Contract;

interface Definition extends \Graphpinator\Typesystem\Entity {
    const dict<classname<\Graphpinator\Directive\Contract\Definition>, vec<string>> INTERFACE_TO_LOCATION = dict[
        \Graphpinator\Directive\Contract\ObjectLocation::class => vec[
            \Graphpinator\Directive\TypeSystemDirectiveLocation::OBJECT,
            \Graphpinator\Directive\TypeSystemDirectiveLocation::INTERFACE,
        ],
        \Graphpinator\Directive\Contract\InputObjectLocation::class => vec[
            \Graphpinator\Directive\TypeSystemDirectiveLocation::INPUT_OBJECT,
        ],
        \Graphpinator\Directive\Contract\ArgumentDefinitionLocation::class => vec[
            \Graphpinator\Directive\TypeSystemDirectiveLocation::ARGUMENT_DEFINITION,
            \Graphpinator\Directive\TypeSystemDirectiveLocation::INPUT_FIELD_DEFINITION,
        ],
        \Graphpinator\Directive\Contract\FieldDefinitionLocation::class => vec[
            \Graphpinator\Directive\TypeSystemDirectiveLocation::FIELD_DEFINITION,
        ],
        \Graphpinator\Directive\Contract\EnumItemLocation::class => vec[
            \Graphpinator\Directive\TypeSystemDirectiveLocation::ENUM_VALUE,
        ],
        \Graphpinator\Directive\Contract\QueryLocation::class => vec[
            \Graphpinator\Directive\ExecutableDirectiveLocation::QUERY,
        ],
        \Graphpinator\Directive\Contract\MutationLocation::class => vec[
            \Graphpinator\Directive\ExecutableDirectiveLocation::MUTATION,
        ],
        \Graphpinator\Directive\Contract\SubscriptionLocation::class => vec[
            \Graphpinator\Directive\ExecutableDirectiveLocation::SUBSCRIPTION,
        ],
        \Graphpinator\Directive\Contract\FieldLocation::class => vec[
            \Graphpinator\Directive\ExecutableDirectiveLocation::FIELD,
            \Graphpinator\Directive\ExecutableDirectiveLocation::INLINE_FRAGMENT,
            \Graphpinator\Directive\ExecutableDirectiveLocation::FRAGMENT_SPREAD,
        ],
    ];

    public function getName(): string;

    public function getDescription(): ?string;

    public function isRepeatable(): bool;

    public function getLocations(): vec<mixed>;

    public function getArguments(): \Graphpinator\Argument\ArgumentSet;
}
