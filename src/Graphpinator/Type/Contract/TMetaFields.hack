namespace Graphpinator\Type\Contract;

trait TMetaFields implements \Graphpinator\Utils\INameable {
    protected ?\Graphpinator\Field\ResolvableFieldSet $metaFields = null;

    public function getMetaFields(): \Graphpinator\Field\ResolvableFieldSet {
        if (!$this->metaFields is \Graphpinator\Field\ResolvableFieldSet) {
            $this->metaFields = $this->getMetaFieldDefinition();
        }

        return $this->metaFields;
    }

    private function getMetaFieldDefinition(): \Graphpinator\Field\ResolvableFieldSet {
        return new \Graphpinator\Field\ResolvableFieldSet(dict[
            '__typename' => new \Graphpinator\Field\ResolvableField(
                '__typename',
                \Graphpinator\Container\Container::String()->notNull(),
                function($_, $_): string {
                    return $this->getName();
                },
            ),
        ]);
    }
}
