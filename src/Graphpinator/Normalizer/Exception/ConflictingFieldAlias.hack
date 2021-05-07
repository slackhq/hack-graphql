namespace Graphpinator\Normalizer\Exception;

final class ConflictingFieldAlias extends \Graphpinator\Normalizer\Exception\NormalizerError
{
    public const MESSAGE = 'Alias name conflicts with different field name.';
}
