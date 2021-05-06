namespace Slack\GraphQL;

use namespace Facebook\HHAST;

// - [x] support searching for classes and printing out the name
// - [ ] support searching for methods tagged with GraphQLField
// - [ ] support inspecting the method args for any method tagged GraphQLField
// - [ ] support codegening a class for any GraphQLObject
// - [ ] support codegening the resolver

final abstract class Generator {

    public static async function generate(string $path): Awaitable<void> {
        $script = await HHAST\from_file_async(HHAST\File::fromPath($path));

        foreach ($script->getDescendantsOfType(HHAST\ClassishDeclaration::class) as $classish) {
            $has_attribute = $classish->getFirstDescendantOfType(HHAST\OldAttributeSpecification::class) is nonnull;
            if (!$has_attribute) continue;

            $rc = new \ReflectionClass($classish->getName()->getText());
            $graphql_object = $rc->getAttributeClass(Object::class);
            if ($graphql_object is nonnull) {
                \print_r(dict['name' => $classish->getName()->getText(), 'graphql_object' => $graphql_object]);

                foreach ($classish->getDescendantsOfType(HHAST\MethodishDeclaration::class) as $methodish) {
                    if (!$methodish->hasAttribute()) continue;

                    $method_name = $methodish->getFunctionDeclHeader()->getName()->getText();
                    $rm = new \ReflectionMethod($classish->getName()->getText(), $method_name);
                    $graphql_field = $rm->getAttributeClass(Field::class);
                    if ($graphql_field is nonnull) {
                        \print_r(dict['name' => $method_name, 'graphql_field' => $graphql_field]);
                    }
                }
            }

        }
    }

}
