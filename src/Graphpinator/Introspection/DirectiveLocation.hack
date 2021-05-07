namespace Graphpinator\Introspection;

final class DirectiveLocation extends \Graphpinator\Type\EnumType {
    const \Graphpinator\Directive\ExecutableDirectiveLocation QUERY =
        \Graphpinator\Directive\ExecutableDirectiveLocation::QUERY;
    const \Graphpinator\Directive\ExecutableDirectiveLocation MUTATION =
        \Graphpinator\Directive\ExecutableDirectiveLocation::MUTATION;
    const \Graphpinator\Directive\ExecutableDirectiveLocation SUBSCRIPTION =
        \Graphpinator\Directive\ExecutableDirectiveLocation::SUBSCRIPTION;
    const \Graphpinator\Directive\ExecutableDirectiveLocation FIELD =
        \Graphpinator\Directive\ExecutableDirectiveLocation::FIELD;
    const \Graphpinator\Directive\ExecutableDirectiveLocation INLINE_FRAGMENT =
        \Graphpinator\Directive\ExecutableDirectiveLocation::INLINE_FRAGMENT;
    const \Graphpinator\Directive\ExecutableDirectiveLocation FRAGMENT_SPREAD =
        \Graphpinator\Directive\ExecutableDirectiveLocation::FRAGMENT_SPREAD;
    const \Graphpinator\Directive\ExecutableDirectiveLocation FRAGMENT_DEFINITION =
        \Graphpinator\Directive\ExecutableDirectiveLocation::FRAGMENT_DEFINITION;
    const \Graphpinator\Directive\ExecutableDirectiveLocation VARIABLE_DEFINITION =
        \Graphpinator\Directive\ExecutableDirectiveLocation::VARIABLE_DEFINITION;
    const \Graphpinator\Directive\TypeSystemDirectiveLocation SCHEMA =
        \Graphpinator\Directive\TypeSystemDirectiveLocation::SCHEMA;
    const \Graphpinator\Directive\TypeSystemDirectiveLocation SCALAR =
        \Graphpinator\Directive\TypeSystemDirectiveLocation::SCALAR;
    const \Graphpinator\Directive\TypeSystemDirectiveLocation INPUT_OBJECT =
        \Graphpinator\Directive\TypeSystemDirectiveLocation::INPUT_OBJECT;
    const \Graphpinator\Directive\TypeSystemDirectiveLocation OBJECT =
        \Graphpinator\Directive\TypeSystemDirectiveLocation::OBJECT;
    const \Graphpinator\Directive\TypeSystemDirectiveLocation INTERFACE =
        \Graphpinator\Directive\TypeSystemDirectiveLocation::INTERFACE;
    const \Graphpinator\Directive\TypeSystemDirectiveLocation UNION =
        \Graphpinator\Directive\TypeSystemDirectiveLocation::UNION;
    const \Graphpinator\Directive\TypeSystemDirectiveLocation FIELD_DEFINITION =
        \Graphpinator\Directive\TypeSystemDirectiveLocation::FIELD_DEFINITION;
    const \Graphpinator\Directive\TypeSystemDirectiveLocation ARGUMENT_DEFINITION =
        \Graphpinator\Directive\TypeSystemDirectiveLocation::ARGUMENT_DEFINITION;
    const \Graphpinator\Directive\TypeSystemDirectiveLocation INPUT_FIELD_DEFINITION =
        \Graphpinator\Directive\TypeSystemDirectiveLocation::INPUT_FIELD_DEFINITION;
    const \Graphpinator\Directive\TypeSystemDirectiveLocation ENUM =
        \Graphpinator\Directive\TypeSystemDirectiveLocation::ENUM;
    const \Graphpinator\Directive\TypeSystemDirectiveLocation ENUM_VALUE =
        \Graphpinator\Directive\TypeSystemDirectiveLocation::ENUM_VALUE;

    const NAME = '__DirectiveLocation';
    const DESCRIPTION = 'Built-in introspection enum.';

    public function __construct() {
        parent::__construct(self::fromConstants());
    }
}
