namespace Graphpinator\Normalizer\Exception;

abstract class NormalizerError extends \Graphpinator\Exception\GraphpinatorBase
{
    public function isOutputable() : bool
    {
        return true;
    }
}
