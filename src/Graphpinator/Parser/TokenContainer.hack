


namespace Graphpinator\Parser;

final class TokenContainer implements \IteratorAggregate<\Graphpinator\Tokenizer\Token> {

    private vec<\Graphpinator\Tokenizer\Token> $tokens = vec[];
    private int $currentIndex = 0;

    public function __construct(\Graphpinator\Source\StringSource $source, bool $skipNotRelevant = true) {
        $tokenizer = new \Graphpinator\Tokenizer\Tokenizer($source, $skipNotRelevant);

        foreach ($tokenizer as $token) {
            if ($token is nonnull) {
                $this->tokens[] = $token;
            }
        }
    }

    public function hasNext(): bool {
        return \array_key_exists($this->currentIndex + 1, $this->tokens);
    }

    public function isEmpty(): bool {
        return \count($this->tokens) === 0;
    }

    public function getCurrent(): \Graphpinator\Tokenizer\Token {
        return $this->tokens[$this->currentIndex];
    }

    public function getPrev(): \Graphpinator\Tokenizer\Token {
        invariant(
            \array_key_exists($this->currentIndex - 1, $this->tokens),
            '%s called on the first token',
            __METHOD__,
        );

        --$this->currentIndex;

        return $this->tokens[$this->currentIndex];
    }

    public function getNext(): \Graphpinator\Tokenizer\Token {
        if (!$this->hasNext()) {
            throw new \Graphpinator\Parser\Exception\UnexpectedEnd($this->getCurrent()->getLocation());
        }

        ++$this->currentIndex;

        return $this->tokens[$this->currentIndex];
    }

    public function peekNext(): \Graphpinator\Tokenizer\Token {
        if (!$this->hasNext()) {
            throw new \Graphpinator\Parser\Exception\UnexpectedEnd($this->getCurrent()->getLocation());
        }

        return $this->tokens[$this->currentIndex + 1];
    }

    public function assertNext<<<__Newable>> reify T as \Graphpinator\Parser\Exception\ExpectedError>(
        string $tokenType,
    ): \Graphpinator\Tokenizer\Token {
        $token = $this->getNext();

        if ($token->getType() !== $tokenType) {
            throw new T($token->getLocation(), $token->getType());
        }

        return $token;
    }

    public function getIterator(): \ArrayIterator<\Graphpinator\Tokenizer\Token> {
        return new \ArrayIterator($this->tokens);
    }
}
