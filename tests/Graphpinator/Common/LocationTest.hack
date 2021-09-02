


namespace Graphpinator\Tests\Unit\Source;

use function Facebook\FBExpect\expect;

final class LocationTest extends \Facebook\HackTest\HackTest {
    public function testSimple(): void {
        $location = new \Graphpinator\Common\Location(10, 100);
        expect(10)->toBeSame($location->getLine());
        expect(100)->toBeSame($location->getColumn());
    }

    public function testSerialize(): void {
        $location = new \Graphpinator\Common\Location(10, 100);
        expect(dict['line' => 10, 'column' => 100])->toBeSame($location->jsonSerialize());
    }
}
