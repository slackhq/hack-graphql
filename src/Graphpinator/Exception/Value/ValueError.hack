namespace Graphpinator\Exception\Value;

abstract class ValueError extends \Graphpinator\Exception\GraphpinatorBase {
    protected bool $outputable;

    public function __construct(string $message, bool $outputable) {
        parent::__construct($message);
        $this->outputable = $outputable;
    }

    public function isOutputable(): bool {
        return $this->outputable;
    }
}
