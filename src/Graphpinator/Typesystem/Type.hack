namespace Graphpinator\Typesystem;

interface Type
{
    public function accept(\Graphpinator\Typesystem\TypeVisitor $visitor) : mixed;
}
