namespace Graphpinator\Normalizer\Exception;

final class FragmentCycle extends \Graphpinator\Normalizer\Exception\NormalizerError
{
    public const MESSAGE = 'Fragment cycle detected.';
}
