namespace Slack\GraphQL;

final class Promise<+T> {
    public function __construct(private (function (): Awaitable<T>) $cb) {}

    public async function resolve(): Awaitable<T> {
        $cb = $this->cb;
        return await $cb();
    }
}