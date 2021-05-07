namespace Graphpinator\Parser\Tests\Unit\FragmentSpread;

use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;

final class InlineFragmentSpreadTest extends \Facebook\HackTest\HackTest {
    public function testConstructor(): void {
        $val = new \Graphpinator\Parser\FragmentSpread\InlineFragmentSpread(
            new \Graphpinator\Parser\Field\FieldSet(vec[], new \Graphpinator\Parser\FragmentSpread\FragmentSpreadSet()),
        );
        expect($val->getFields()->count())->toBeSame(0);
        expect($val->getDirectives()->count())->toBeSame(0);
    }
}
