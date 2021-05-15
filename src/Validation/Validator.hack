namespace Slack\GraphQL\Validation;

use namespace HH\Lib\Vec;
use type \Slack\GraphQL\__Private\ParallelVisitor;

final class Validator {
    private static keyset<classname<ValidationRule>> $rules = keyset[
        FieldsOnCorrectTypeRule::class,
        ScalarLeafsRule::class,
    ];

    public function __construct(private \Slack\GraphQL\BaseSchema $schema) {}

    public function validate(\Graphpinator\Parser\ParsedRequest $request): vec<\Slack\GraphQL\UserFacingError> {
        $type_info = new TypeInfo($this->schema);
        $ctx = new ValidationContext($this->schema, $type_info);

        $visitor = new ParallelVisitor(Vec\map(static::$rules, $rule ==> new $rule($ctx)));
        $visitor = $visitor->runAfter($type_info);
        $visitor->walk($request);

        return $ctx->getErrors();
    }

    public static function setRules(keyset<classname<ValidationRule>> $rules): void {
        static::$rules = $rules;
    }
}
