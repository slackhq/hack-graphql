namespace Slack\GraphQL\Codegen;

interface ITypeWithFieldsBuilder {
    public function getFieldNames(): keyset<string>;
}
