use namespace Slack\GraphQL\Validation;

final class KnownTypeNamesRuleTest extends BaseValidationTest {

    const classname<Validation\ValidationRule> RULE = Validation\KnownTypeNamesRule::class;

    public static function getTestCases(): this::TTestCases {
        return dict[
            'known type names are valid' => tuple(
                'query Foo(
                    $id: Int!
                    $is_active: Boolean!
                    $favorite_color: FavoriteColor!
                ) {
                    user(id: $id) {
                        name
                    }
                    takes_favorite_color(favorite_color: $favorite_color)
                }',
                vec[],
            ),

            'unknown type names are invalid' => tuple(
                'query Foo(
                    $id: Int!
                    $is_active: Boolean!
                    $favorite_color: JumbledUpLetters!
                ) {
                    user(id: $id) {
                        name
                    }
                    takes_favorite_color(favorite_color: $favorite_color)
                }',
                vec[
                    shape(
                        'message' => 'Unknown type "JumbledUpLetters".',
                        'location' => shape('line' => 4, 'column' => 38),
                    )
                ]
            )
        ];
    }
}
