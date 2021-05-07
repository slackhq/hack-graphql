namespace Graphpinator\Typesystem;

interface Entity extends \Graphpinator\Typesystem\Component
{
    public function accept(\Graphpinator\Typesystem\EntityVisitor $visitor) : mixed;
}
