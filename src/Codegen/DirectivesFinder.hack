
namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\{C, Str, Vec};
use type Facebook\DefinitionFinder\ScannedMethod;

final class DirectivesFinder {
    public function __construct(private keyset<string> $directives) {}

    public async function findDirectivesForField(ScannedMethod $method): Awaitable<vec<string>> {
        if (!$this->directives) {
            return vec[];
        }

        $directives = vec[];

        // Get all use namespaces and types present
        $file_path = $method->getFileName();
        $use_decls = await self::getUseDeclarations($file_path);

        // For each attribute, see if it matches a user-defined directive
        // This requires building the qualified name, which is not
        // available in `getAttributes`, unfortunately.
        $attributes = $method->getAttributes();
        foreach ($attributes as $attribute => $args) {
            // Consider names starting with `\` to be fully qualified
            if (!Str\starts_with($attribute, '\\')) {
                //
                // Try to determine the fully qualified name of the attribute.
                //
                // There are two cases here: 
                // If the attribute is declared as `Baz`, then either:
                //      1) Baz is not namespaced at all.
                //      2) Baz is a imported via a use type statement, e.g., `use type Foo\Bar\Baz`.
                // If the attribute is declared as `Bar/Baz`, then either:
                //      1) Bar is a top-level namespace.
                //      2) Bar is imported via a use namespace statement, e.g., `use namespace Foo\Bar`.
                //
                // In each case, we need to match the whatever comes before the first `\` in the attribute
                // name (or the whole attribute name, if it contains no slashes) with whatever comes after
                // the last `\` in each use type or use namespace statement.
                //
                // Once we have a match, we can build the fully qualified name by adding the attribute name
                // to everything that comes before the last `\` in the eligible use statement.
                //
                $needle = Str\split($attribute, '\\')
                    |> C\firstx($$);
                $attribute = '\\'.$attribute;
                foreach ($use_decls as $decl) {
                    if (C\contains_key($decl['leaves'], $needle)) {
                        // We have a match such as `Bar\Baz` with `use namespace Foo\Bar`;
                        // build the qualified name as `Foo\Bar\Baz`.
                        $attribute = '\\'.$decl['root'].$attribute;
                        break;
                    }
                }
            }

            if (C\contains_key($this->directives, $attribute)) {
                $directives[] = Str\format(
                    'new %s(%s)',
                    $attribute,
                    Vec\map(
                        $args,
                        $arg ==> \var_export($arg, true)
                            |> Str\replace($$, 'varray', 'vec')
                            |> Str\replace($$, 'darray', 'dict')
                            |> Str\replace($$, 'array', 'shape')
                            |> Str\replace($$, 'vec ', 'vec')
                            |> Str\replace($$, 'dict ', 'dict')
                            |> Str\replace($$, 'shape ', 'shape')
                    )
                        |> Str\join($$, ', '),
                );
            }
        }

        return $directives;
    }

    <<__Memoize>>
    private static async function getUseDeclarations(string $file_path): Awaitable<vec<shape(
        'root' => string,
        'leaves' => keyset<string>,
    )>> {
        $ast = await \Facebook\HHAST\from_file_async(\Facebook\HHAST\File::fromPath($file_path));
        return $ast->getDescendantsByType<\Facebook\HHAST\INamespaceUseDeclaration>()
            |> Vec\map($$, $decl ==> {
                $kind = $decl->getKind();
                if ($kind is null || $kind->getText() === 'function') {
                    return null;
                }
                $leaves = $decl->getClausesx()->toVec();
                if ($decl is \Facebook\HHAST\NamespaceGroupUseDeclaration) {
                    $root = $decl->getPrefixx()->getCode()
                        |> Str\strip_suffix($$, '\\');
                    $leaves = Vec\map($leaves, $leaf ==> $leaf->getFirstToken()?->getCode())
                        |> Vec\filter_nulls($$);
                } else {
                    $leaves = C\firstx($leaves)
                        |> Str\split($$->getCode(), '\\');
                    $num_leaves = C\count($leaves);
                    if ($num_leaves > 1) {
                        $root = Vec\take($leaves, $num_leaves - 1)
                            |> Str\join($$, '\\');
                        $leaves = Vec\drop($leaves, $num_leaves - 1);
                    } else {
                        $root = '';
                    }
                }
                return shape(
                    'root' => $root,
                    'leaves' => keyset($leaves),
                );
            })
            |> Vec\filter_nulls($$);
    }
}
