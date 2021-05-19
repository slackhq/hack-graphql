namespace Slack\GraphQL\Introspection\V2;

use namespace Slack\GraphQL;

<<GraphQL\InterfaceType('__Field', 'Field introspection'), __ConsistentConstruct>>
final class __Field {

    public function __construct(private string $name, private __Type $inner_type) {}

    <<GraphQL\Field('name', 'Name of the field')>>
    public function getName(): string {
        return $this->name;
    }

    <<GraphQL\Field('description', 'Description of the field')>>
    public function getDescription(): ?string {
        return null;
    }

    <<GraphQL\Field('args', 'Args of the field')>>
    public function getArgs(): vec<__InputValue> {
        return vec[];
    }

    <<GraphQL\Field('type', 'Type of the field')>>
    public function getType(): __Type {
        return $this->inner_type;
    }

    <<GraphQL\Field('isDeprecated', 'Boolean for whether or not the field is deprecated')>>
    public function isDeprecated(): bool {
        return false;
    }

    <<GraphQL\Field('deprecationReason', 'Reason the field was deprecated')>>
    public function getDeprecationReason(): ?string {
        return null;
    }

    public static function for(string $name, __Type $inner_type): this {
        return new static($name, $inner_type);
    }

}
