namespace Graphpinator\Parser\Tests\Unit\FragmentSpread;

use namespace HH\Lib\C;
use function Facebook\FBExpect\expect;

final class NamedFragmentSpreadTest extends \Facebook\HackTest\HackTest {
    public function testConstructor(): void {
        $val = new \Graphpinator\Parser\FragmentSpread\NamedFragmentSpread('fragment');
        expect($val->getName())->toBeSame('fragment');
        expect(C\count($val->getDirectives()))->toBeSame(0);
    }
}
