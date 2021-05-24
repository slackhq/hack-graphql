namespace Graphpinator\Parser\Tests\Unit\FragmentSpread;

use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;

final class InlineFragmentSpreadTest extends \Facebook\HackTest\HackTest {
    public function testConstructor(): void {
        $val = new \Graphpinator\Parser\FragmentSpread\InlineFragmentSpread(
            new \Graphpinator\Common\Location(0, 0),
            new \Graphpinator\Parser\Field\SelectionSet(
                new \Graphpinator\Common\Location(0, 0),
                vec[],
            ),
        );
        expect(C\count($val->getSelectionSet()->getItems()))->toBeSame(0);
        expect(C\count($val->getDirectives()))->toBeSame(0);
    }
}
