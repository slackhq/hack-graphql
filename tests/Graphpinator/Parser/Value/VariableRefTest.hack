namespace Graphpinator\Parser\Tests\Unit\Value;

use function Facebook\FBExpect\expect;

final class VariableRefTest extends \Facebook\HackTest\HackTest {
    public function testGetRawValue(): void {
        expect(() ==> {
            $val = new \Graphpinator\Parser\Value\VariableRef('varName');
            $val->getRawValue();
        })->toThrow(\RuntimeException::class, 'Operation not supported.');
    }
}
