namespace Graphpinator\Utils;

/**
 * Trait TOptionalDescription which manages description for classes which support it.
 */
trait TOptionalDescription {
    private ?string $description = null;

    public function getDescription(): ?string {
        return $this->description;
    }

    public function setDescription(string $description): this {
        $this->description = $description;

        return $this;
    }
}
