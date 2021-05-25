namespace Slack\GraphQL\Validation;

use namespace HH\Lib\Vec;
use type \Slack\GraphQL\__Private\{DependencyInfo, TypeInfo};
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
        $dependencies = new DependencyInfo();
        $type_info = new TypeInfo($this->schema);
        $ctx = new ValidationContext($this->schema, $request, $type_info);

        $rules = Vec\map($this->rules, $rule ==> new $rule($ctx));

        $visitor = new ParallelVisitor(Vec\concat(vec[$dependencies, $type_info], $rules));
        $visitor->walk($request);

        foreach ($rules as $rule) {
            $rule->finalize($dependencies);
        }

        return $ctx->getErrors();
    }

    public function setRules(keyset<classname<ValidationRule>> $rules): void {
        $this->rules = $rules;
    }
}
