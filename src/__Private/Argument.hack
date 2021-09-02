


namespace Slack\GraphQL\__Private;

final class Argument {
    public function __construct(private mixed $value) {}

    public function asInt(): int {
        return $this->value as int;
    }

    public function asString(): string {
        return $this->value as string;
    }

    public function asBool(): bool {
        return $this->value as bool;
    }

    public function asMixed(): mixed {
        return $this->value;
    }
}
