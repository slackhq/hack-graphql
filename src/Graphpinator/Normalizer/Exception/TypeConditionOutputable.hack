namespace Graphpinator\Normalizer\Exception;

final class TypeConditionOutputable extends \Graphpinator\Normalizer\Exception\NormalizerError
{
    public const MESSAGE = 'Fragment type condition must be outputable composite type.';
}
