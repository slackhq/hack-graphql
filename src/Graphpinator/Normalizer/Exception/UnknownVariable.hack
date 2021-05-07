namespace Graphpinator\Normalizer\Exception;

final class UnknownVariable extends \Graphpinator\Normalizer\Exception\NormalizerError
{
    public const MESSAGE = 'Unknown variable "%s".';

    public function __construct(string $varName)
    {
        $this->messageArgs = [$varName];

        parent::__construct();
    }
}
