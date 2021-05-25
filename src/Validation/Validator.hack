namespace Slack\GraphQL\Validation;

use namespace HH\Lib\Vec;
use type \Slack\GraphQL\__Private\{FragmentInfo, TypeInfo, VariableInfo};
use type \Slack\GraphQL\__Private\ParallelVisitor;

final class Validator {
    private keyset<classname<ValidationRule>> $rules = keyset[
        FieldsOnCorrectTypeRule::class,
        KnownArgumentNamesRule::class,
        KnownTypeNamesRule::class,
        NoUndefinedVariablesRule::class,
        ScalarLeafsRule::class,
    ];

    public function __construct(private classname<\Slack\GraphQL\BaseSchema> $schema) {}

    public function validate(\Graphpinator\Parser\ParsedRequest $request): vec<\Slack\GraphQL\UserFacingError> {
        $fragment_info = new FragmentInfo();
        $type_info = new TypeInfo($this->schema);
        $variable_info = new VariableInfo($fragment_info);
        $ctx = new ValidationContext($this->schema, $fragment_info, $type_info, $variable_info);

        $visitor = new ParallelVisitor(Vec\concat(
            vec[$fragment_info, $type_info, $variable_info],
            Vec\map($this->rules, $rule ==> new $rule($ctx))
        ));
        $visitor->walk($request);

        return $ctx->getErrors();
    }

    public function setRules(keyset<classname<ValidationRule>> $rules): void {
        $this->rules = $rules;
    }
}
