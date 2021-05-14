namespace Slack\GraphQL;


final class EnumType extends __Private\GraphQLTypeInfo implements \HH\EnumAttribute {
    public function getInputType(): string {
        return $this->getType().'InputType';
    }

    public function getOutputType(): string {
        return $this->getType().'OutputType';
    }
}