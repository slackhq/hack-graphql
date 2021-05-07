namespace Graphpinator\Type\Contract;

/**
 * Interface InterfaceImplementor which marks types which can implement interface - currently Type and Interface.
 */
//@phpcs:ignore SlevomatCodingStandard.Classes.SuperfluousInterfaceNaming.SuperfluousPrefix
interface InterfaceImplementor<T> extends \Graphpinator\Type\Contract\Definition {
    /**
     * Returns fields defined for this type.
     */
    public function getFields(): T;

    /**
     * Returns interfaces, which this type implements.
     */
    public function getInterfaces(): \Graphpinator\Type\InterfaceSet;

    /**
     * Checks whether this type implements given interface.
     * @param \Graphpinator\Type\InterfaceType $interface
     */
    public function implements(\Graphpinator\Type\InterfaceType $interface): bool;
}
