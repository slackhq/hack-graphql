namespace Graphpinator\Parser\Tests\Unit\Value;

use function Facebook\FBExpect\expect;

final class NamedValueTest extends \Facebook\HackTest\HackTest {
    public function simpleDataProvider(): vec<(\Graphpinator\Parser\Value\Value, string)> {
        return vec[
            tuple(new \Graphpinator\Parser\Value\Literal(123), 'name'),
            tuple(new \Graphpinator\Parser\Value\Literal(123.123), 'name'),
            tuple(new \Graphpinator\Parser\Value\Literal('123'), 'name'),
            tuple(new \Graphpinator\Parser\Value\Literal(true), 'name'),
            tuple(new \Graphpinator\Parser\Value\ListVal(vec[]), 'name'),
        ];
    }

    /**
     * @dataProvider simpleDataProvider
     * @param \Graphpinator\Parser\Value\Value $value
     * @param string $name
     */
    <<\Facebook\HackTest\DataProvider('simpleDataProvider')>>
    public function testSimple(\Graphpinator\Parser\Value\Value $value, string $name): void {
        $obj = new \Graphpinator\Parser\Value\ArgumentValue($value, $name);

        expect($name)->toBeSame($obj->getName());
        expect($value)->toBeSame($obj->getValue());
        expect($value->getRawValue())->toBeSame($obj->getValue()->getRawValue());
    }
}
