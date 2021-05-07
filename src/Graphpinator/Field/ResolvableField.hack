namespace Graphpinator\Field;

final class ResolvableField<T> extends \Graphpinator\Field\Field {
    private ?(function(T): mixed) $resolveFn;

    public function __construct(
        string $name,
        \Graphpinator\Type\Contract\Outputable $type,
        ?(function(T): mixed) $resolveFn = null,
    ) {
        parent::__construct($name, $type);
        $this->resolveFn = $resolveFn;
    }

    public static function create(
        string $name,
        \Graphpinator\Type\Contract\Outputable $type,
        ?(function(T): mixed) $resolveFn = null,
    ): this {
        return new self($name, $type, $resolveFn);
    }

    public function getResolveFunction(): ?(function(T): mixed) {
        return $this->resolveFn;
    }
}
