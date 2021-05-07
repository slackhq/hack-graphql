namespace Graphpinator\Normalizer\Exception;

final class SelectionOnLeaf extends \Graphpinator\Normalizer\Exception\NormalizerError
{
    public const MESSAGE = 'Cannot require fields on leaf type.';
}
