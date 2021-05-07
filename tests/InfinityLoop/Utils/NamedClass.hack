namespace Infinityloop\Tests\Utils;

final class NamedClass
{
    public string $name;

    public function __construct(string $name)
    {
        $this->name = $name;
    }
}
