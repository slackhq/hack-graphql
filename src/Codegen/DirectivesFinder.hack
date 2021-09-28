


namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Dict, Str, Vec};

final class DirectivesFinder {
    public function __construct(
        private shape(
            ?'fields' => keyset<classname<\Slack\GraphQL\FieldDirective>>,
            ?'objects' => keyset<classname<\Slack\GraphQL\ObjectDirective>>,
        ) $directives,
        private dict<string, string> $hack_class_to_graphql_interface,
    ) {}

    public function findDirectivesForField(\ReflectionMethod $rm): dict<string, vec<string>> {
        return self::findDirectives(
            $this->directives['fields'] ?? keyset[],
            $directive_type ==> $rm->getAttributeClass($directive_type),
        );
    }

    public function findDirectivesForObject(\ReflectionClass $rc): dict<string, vec<string>> {
        return vec[$rc->getName()]
            |> Vec\concat(
                $$,
                get_interfaces($rc->getName(), $this->hack_class_to_graphql_interface)
                    |> Vec\keys($$),
            )
            |> Vec\reverse($$)
            |> Vec\map($$, $object_name ==> $this->findDirectivesForObjectName($object_name))
            |> Dict\merge(C\firstx($$), ...Vec\drop($$, 1));
    }

    <<__Memoize>>
    private function findDirectivesForObjectName(string $object_name): dict<string, vec<string>> {
        $rc = new \ReflectionClass($object_name);
        return self::findDirectives(
            $this->directives['objects'] ?? keyset[],
            $directive_type ==> $rc->getAttributeClass($directive_type),
        );
    }

    private static function findDirectives<T as \Slack\GraphQL\Directive>(
        keyset<classname<T>> $custom_directive_types,
        (function(classname<T>): ?T) $getter,
    ): dict<string, vec<string>> {
        $directives = dict[];

        foreach ($custom_directive_types as $directive_type) {
            $directive = $getter($directive_type);
            if ($directive is nonnull) {
                $rc = new \ReflectionClass($directive);
                $directives[$rc->getName()] = $directive->formatArgs();
            }
        }

        return $directives;
    }
}
