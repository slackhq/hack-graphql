namespace Graphpinator\Normalizer\Exception;

final class ConflictingFieldType extends \Graphpinator\Normalizer\Exception\NormalizerError
{
    public const MESSAGE = 'Fields are not compatible for merging: types do not match.';
}
