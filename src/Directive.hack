


namespace Slack\GraphQL;

/**
 * A custom schema directive.
 */
interface Directive {

    /**
     * Return the arguments necessary to reconstitute the directive by calling `new`.
     *
     * For example, if the directive has the following constructor:
     *
     *  __construct(private float $x, private string $y) {}
     *
     * You'd implement `formatArgs()` as follows:
     *
     *  return vec[Str\format("%f", $this->x), Str\format('"%s"', $this->y)];
     */
    public function formatArgs(): vec<string>;
}

/**
 * A field-level directive.
 */
interface FieldDirective extends Directive, \HH\MethodAttribute {

    /**
     * Hook which executes before resolving a field.
     */
    public function beforeResolveField(mixed $object, string $field): Awaitable<void>;
}

/**
 * An object-level directive.
 */
interface ObjectDirective extends Directive, \HH\ClassAttribute {

    /**
     * Hook which executes before resolving an object.
     */
    public function beforeResolveObject(string $object_name): Awaitable<void>;
}
