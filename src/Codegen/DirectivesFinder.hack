namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Str, Vec};
use type Facebook\DefinitionFinder\ScannedMethod;

final class DirectivesFinder {
    public function __construct(private keyset<string> $directives) {}

    public async function findDirectivesForField(ScannedMethod $method): Awaitable<vec<string>> {
        $directives = vec[];

        // Get all use namespaces and types present
        $file_path = $method->getFileName();
        $use_decls = await self::getUseDeclarations($file_path);

        // For each attribute, see if it matches a user-defined directive
        // This requires building the qualified name, which is not
        // available in `getAttributes`, unfortunately.
        $attributes = $method->getAttributes();
        foreach ($attributes as $attribute => $args) {
            if (Str\starts_with($attribute, '\\')) {
                $qualified_name = $attribute;
            } else {
                $namespace = Str\split($attribute, '\\')
                    |> Vec\take($$, C\count($$) - 1)
                    |> Str\join($$, '\\');
                // If it's a type, not a namespace, then there's nothing to split
                // so just use the whole string.
                if (!$namespace) {
                    $namespace = $attribute;
                }
                $qualified_name = '';
                foreach ($use_decls as $decl) {
                    if (C\contains_key($decl['clauses'], $namespace)) {
                        $qualified_name = '\\'.$decl['root'].'\\'.$attribute;
                        break;
                    }
                }
            }
            if (C\contains_key($this->directives, $qualified_name)) {
                $directives[] = Str\format(
                    'new %s(%s)',
                    $qualified_name,
                    Vec\map($args, $arg ==> \var_export($arg, true)
                        |> Str\replace($$, 'varray', 'vec')
                        |> Str\replace($$, 'darray', 'dict')
                        |> Str\replace($$, 'array', 'shape')
                    )
                        |> Str\join($$, ', ')
                );
            }
        }

        return $directives;
    }

    <<__Memoize>>
    private static async function getUseDeclarations(string $file_path): Awaitable<vec<shape(
        'root' => string,
        'clauses' => keyset<string>
    )>> {
        $ast = await \Facebook\HHAST\from_file_async(\Facebook\HHAST\File::fromPath($file_path));
        return $ast->getDescendantsByType<\Facebook\HHAST\INamespaceUseDeclaration>()
            |> Vec\map($$, $decl ==> {
                $kind = $decl->getKind();
                if ($kind is null || $kind->getText() === 'function') {
                    return null;
                }
                $clauses = $decl->getClausesx()->toVec();
                if ($decl is \Facebook\HHAST\NamespaceGroupUseDeclaration) {
                    $root = $decl->getPrefixx()->getCode()
                        |> Str\strip_suffix($$, '\\');
                    $clauses = Vec\map($clauses, $clause ==> $clause->getFirstToken()?->getCode())
                        |> Vec\filter_nulls($$);
                } else {
                    $clauses = C\firstx($clauses)
                        |> Str\split($$->getCode(), '\\');
                    $num_clauses = C\count($clauses);
                    if ($num_clauses > 1) {
                        $root = Vec\take($clauses, $num_clauses - 1)
                            |> Str\join($$, '\\');
                        $clauses = Vec\drop($clauses, $num_clauses - 1);
                    } else {
                        $root = '';
                    }
                }
                return shape(
                    'root' => $root,
                    'clauses' => keyset($clauses),
                );
            })
            |> Vec\filter_nulls($$);
    }
}