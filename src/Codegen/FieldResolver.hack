namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Dict, Vec};
use namespace Facebook\DefinitionFinder;


/**
 * Utility class which handles traversing the object graph and finding all fields for a class.
 */
final class FieldResolver {
    private dict<string, DefinitionFinder\ScannedClassish> $scanned_classes;
    private dict<string, vec<Field>> $resolved_fields = dict[];

    public function __construct(vec<DefinitionFinder\ScannedClassish> $classes) {
        $this->scanned_classes = Dict\from_values($classes, $class ==> $class->getName());
    }

    public function resolveFields(): dict<string, vec<Field>> {
        foreach ($this->scanned_classes as $class) {
            if (!$this->shouldResolve($class)) continue;
            $this->resolveClass($class);
        }
        return $this->resolved_fields;
    }

    private function shouldResolve(DefinitionFinder\ScannedClassish $class): bool {
        $rc = new \ReflectionClass($class->getName());
        return (
            $rc->getAttributeClass(\Slack\GraphQL\InterfaceType::class)
                ?? $rc->getAttributeClass(\Slack\GraphQL\ObjectType::class)
        ) is nonnull;
    }

    private function resolveClass(DefinitionFinder\ScannedClassish $class): vec<Field> {
        if (C\contains_key($this->resolved_fields, $class->getName())) {
            return $this->resolved_fields[$class->getName()];
        }

        $fields = vec[];

        $parents = $class->getInterfaceNames();
        $parent_class_name = $class->getParentClassName();
        if ($parent_class_name is nonnull) {
            $parents[] = $parent_class_name;
        }

        foreach ($parents as $parent) {
            $parent_class = $this->scanned_classes[$parent] ?? null;
            if ($parent_class) {
                $fields = Vec\concat($fields, $this->resolveClass($parent_class));
            }
        }

        $fields = Vec\concat($fields, $this->collectObjectFields($class));
        $this->resolved_fields[$class->getName()] = $fields;
        return $fields;
    }

    private function collectObjectFields(DefinitionFinder\ScannedClassish $class): vec<Field> {
        $fields = vec[];
        foreach ($class->getMethods() as $method) {
            if (C\is_empty($method->getAttributes())) continue;

            $rm = new \ReflectionMethod($class->getName(), $method->getName());
            $graphql_field = $rm->getAttributeClass(\Slack\GraphQL\Field::class);
            if ($graphql_field is null) continue;

            $fields[] = new Field($class, $method, $rm, $graphql_field);
        }

        return $fields;
    }
}
