use namespace HH\Lib\C;

final class DirectiveContext {
    public static dict<string, dict<string, dict<string, int>>> $field_resolutions = dict[];
    public static dict<string, dict<string, int>> $object_resolutions = dict[];

    public static function reset(): void {
        self::$field_resolutions = dict[];
        self::$object_resolutions = dict[];
    }

    public static function incrementResolveField(
        \Slack\GraphQL\FieldDirective $directive,
        mixed $object,
        string $field,
    ): void {
        $directive_class = \get_class($directive);
        if (!C\contains_key(self::$field_resolutions, $directive_class)) {
            self::$field_resolutions[$directive_class] = dict[];
        }

        $object_class = \get_class($object);
        if (!C\contains_key(self::$field_resolutions[$directive_class], $object_class)) {
            self::$field_resolutions[$directive_class][$object_class] = dict[];
        }

        if (!C\contains_key(self::$field_resolutions[$directive_class][$object_class], $field)) {
            self::$field_resolutions[$directive_class][$object_class][$field] = 0;
        }

        self::$field_resolutions[$directive_class][$object_class][$field]++;
    }

    public static function incrementResolveObject(
        \Slack\GraphQL\ObjectDirective $directive,
        string $object_name,
    ): void {
        $directive_class = \get_class($directive);
        if (!C\contains_key(self::$object_resolutions, $directive_class)) {
            self::$object_resolutions[$directive_class] = dict[];
        }

        if (!C\contains_key(self::$object_resolutions[$directive_class], $object_name)) {
            self::$object_resolutions[$directive_class][$object_name] = 0;
        }

        self::$object_resolutions[$directive_class][$object_name]++;
    }
}
