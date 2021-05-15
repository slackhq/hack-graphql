namespace Slack\GraphQL\Introspection;

/**
* Types are nullable by default in GraphQL, however in this framework, we wrap
* nullable types with either NullableInputType or NullableOutputType. This trait
* lets us read introspection fields from the inner type since we don't need to
* specify anything for nullable fields during introspection.
*/
trait IntrospectNullableType implements IHasInnerType {

    public function getName(): ?string {
        return $this->getInnerType()->getName();
    }

    public function getKind(): __TypeKind {
        return $this->getInnerType()->getKind();
    }

    public function getOfType(): ?__Type {
        return $this->getInnerType()->getOfType();
    }
}
