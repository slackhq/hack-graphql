namespace Graphpinator\DirectiveUsage;

final class DirectiveUsageSet extends \Infinityloop\Utils\ObjectSet<DirectiveUsage> {

    public function validateInvariance(DirectiveUsageSet $child): void {
        foreach ($this as $index => $usage) {
            $directive = $usage->getDirective();

            if (
                $child->offsetExists($index) &&
                $usage->getArgumentValues()->isSame($child->offsetGet($index)->getArgumentValues())
            ) {
                continue;
            }

            throw new \Graphpinator\Exception\Type\InterfaceDirectivesNotPreserved();
        }
    }

    public function validateCovariance(DirectiveUsageSet $child): void {
        self::compareVariance($this, $child);
    }

    public function validateContravariance(DirectiveUsageSet $child): void {
        self::compareVariance($child, $this);
    }

    private static function compareVariance(DirectiveUsageSet $biggerSet, DirectiveUsageSet $smallerSet): void {
        $childIndex = 0;

        foreach ($biggerSet as $index => $usage) {
            if ($smallerSet->offsetExists($childIndex)) {
                // $usage->getDirective()->validateVariance(
                //     $usage->getArgumentValues(),
                //     $smallerSet->offsetGet($childIndex)->getArgumentValues(),
                // );
                ++$childIndex;

                continue;
            }

            // $usage->getDirective()->validateVariance($usage->getArgumentValues(), null);
        }
    }
}
