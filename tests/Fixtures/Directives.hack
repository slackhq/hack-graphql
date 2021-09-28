


namespace Directives;

use namespace Slack\GraphQL;
use namespace HH\Lib\{C, Str, Vec};

abstract class RoleType {}
final class AdminRoleType extends RoleType {}
final class StaffRoleType extends RoleType {}

final class HasRole implements \Slack\GraphQL\FieldDirective, \Slack\GraphQL\ObjectDirective {
    public function __construct(private vec<classname<RoleType>> $roles) {}

    public function formatArgs(): vec<string> {
        return vec[Str\format(
            'vec[%s]',
            Vec\map($this->roles, $role ==> Str\format('\%s::class', $role)) |> Str\join($$, ', '),
        )];
    }

    public async function beforeResolveField(mixed $object, string $field): Awaitable<void> {
        \DirectiveContext::incrementResolveField($this, $object, $field);
    }

    public async function beforeResolveObject(string $object_name): Awaitable<void> {
        \DirectiveContext::incrementResolveObject($this, $object_name);
    }
}

final class LogSampled implements \Slack\GraphQL\FieldDirective, \Slack\GraphQL\ObjectDirective {
    public function __construct(private float $frequency, private string $prefix) {}

    public function formatArgs(): vec<string> {
        return vec[
            Str\format('%f', $this->frequency),
            Str\format('"%s"', $this->prefix),
        ];
    }

    public async function beforeResolveField(mixed $object, string $field): Awaitable<void> {
        \DirectiveContext::incrementResolveField($this, $object, $field);
    }

    public async function beforeResolveObject(string $object_name): Awaitable<void> {
        \DirectiveContext::incrementResolveObject($this, $object_name);
    }
}

final class TestShapeDirective implements \Slack\GraphQL\FieldDirective {
    public function __construct(private shape('foo' => int, 'bar' => string) $args, private bool $extra) {}

    public function formatArgs(): vec<string> {
        return vec[
            Str\format('shape(\'foo\' => %d, \'bar\' => "%s")', $this->args['foo'], $this->args['bar']),
            $this->extra ? 'true' : 'false',
        ];
    }

    public async function beforeResolveField(mixed $object, string $field): Awaitable<void> {
        \DirectiveContext::incrementResolveField($this, $object, $field);
    }
}

final class AnotherDirective implements \Slack\GraphQL\FieldDirective, \Slack\GraphQL\ObjectDirective {
    public function formatArgs(): vec<string> {
        return vec[];
    }

    public async function beforeResolveField(mixed $object, string $field): Awaitable<void> {
        \DirectiveContext::incrementResolveField($this, $object, $field);
    }

    public async function beforeResolveObject(string $object_name): Awaitable<void> {
        \DirectiveContext::incrementResolveObject($this, $object_name);
    }
}
