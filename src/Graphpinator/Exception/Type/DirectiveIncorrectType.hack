namespace Graphpinator\Exception\Type;

final class DirectiveIncorrectType extends \Graphpinator\Exception\Type\TypeError {
    public function __construct() {
        parent::__construct('Directive cannot be used on this type or has incompatible settings.');
    }
}
