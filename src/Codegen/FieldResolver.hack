namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Dict};
use namespace Facebook\DefinitionFinder;


/**
 * Utility class which handles traversing the object graph and finding all fields for a class.
 */
final class FieldResolver {
    private dict<string, DefinitionFinder\ScannedClassish> $scanned_classes;
    private dict<string, dict<string, FieldBuilder>> $resolved_fields = dict[];

    public function __construct(vec<DefinitionFinder\ScannedClassish> $classes) {
        $this->scanned_classes = Dict\from_values($classes, $class ==> $class->getName());
    }

    public function resolveFields(): dict<string, vec<FieldBuilder>> {
        foreach ($this->scanned_classes as $class) {
            if (!$this->shouldResolve($class)) continue;
            $this->resolveClass($class);
        }
        return Dict\map($this->resolved_fields, $fields ==> vec(Dict\sort_by_key($fields)));
    }

    private function shouldResolve(DefinitionFinder\ScannedClassish $class): bool {
        $rc = new \ReflectionClass($class->getName());
        return (
            $rc->getAttributeClass(\Slack\GraphQL\InterfaceType::class)
                ?? $rc->getAttributeClass(\Slack\GraphQL\ObjectType::class)
        ) is nonnull;
    }

    private function resolveClass(DefinitionFinder\ScannedClassish $class): dict<string, FieldBuilder> {
        if (C\contains_key($this->resolved_fields, $class->getName())) {
            return $this->resolved_fields[$class->getName()];
        }

        $fields = dict[];

        $rc = new \ReflectionClass($class->getName());
        $parents = $rc->getInterfaceNames();
        $parent_class = $rc->getParentClass();
        if ($parent_class is \ReflectionClass) {
            $parents[] = $parent_class->getName();
        }

        foreach ($parents as $parent) {
            $parent_class = $this->scanned_classes[$parent] ?? null;
            if ($parent_class) {
                $fields = Dict\merge($fields, $this->resolveClass($parent_class));
            }
        }

        $fields = Dict\merge($fields, $this->collectObjectFields($class));
        $this->resolved_fields[$class->getName()] = $fields;
        return $fields;
    }

    private function collectObjectFields(DefinitionFinder\ScannedClassish $class): dict<string, FieldBuilder> {
        $fields = dict[];
        foreach ($class->getMethods() as $method) {
            if (C\is_empty($method->getAttributes())) continue;

            $rm = new \ReflectionMethod($class->getName(), $method->getName());
            $graphql_field = $rm->getAttributeClass(\Slack\GraphQL\Field::class);
            if ($graphql_field is null) continue;

            $fields[$graphql_field->getName()] = FieldBuilder::fromReflectionMethod($graphql_field, $rm);
        }

        return $fields;
    }
}
