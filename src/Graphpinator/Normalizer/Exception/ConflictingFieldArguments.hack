namespace Graphpinator\Normalizer\Exception;

final class ConflictingFieldArguments extends \Graphpinator\Normalizer\Exception\NormalizerError
{
    public const MESSAGE = 'Arguments cannot be merged.';
}
