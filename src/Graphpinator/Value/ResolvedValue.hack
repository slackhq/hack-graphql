namespace Graphpinator\Value;

interface ResolvedValue extends \Graphpinator\Value\Value
{
    public function getType() : \Graphpinator\Type\Contract\Outputable;
}
