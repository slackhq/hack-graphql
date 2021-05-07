namespace Slack\GraphQL\Types;

final class ListOutputType<TInner as OutputType> extends OutputType {

    public function __construct(
        private TInner $innerType,
        bool $is_nullable,
    ) {
        parent::__construct($is_nullable);
    }

    <<__Override>>
    public function getName(): ?string {
        return null;
    }

    public function getInnerType(): TInner {
        return $this->innerType;
    }
}
