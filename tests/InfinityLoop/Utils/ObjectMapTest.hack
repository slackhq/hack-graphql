namespace Infinityloop\Tests\Utils;

use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;

final class ObjectMapTest extends \Facebook\HackTest\HackTest {
    public function testMerge(): void {
        $instance = new \Infinityloop\Tests\Utils\NamedClassSet(dict[
            'a' => new \Infinityloop\Tests\Utils\NamedClass('a'),
            'b' => new \Infinityloop\Tests\Utils\NamedClass('b'),
            'c' => new \Infinityloop\Tests\Utils\NamedClass('c'),
        ]);

        $secondInstance = new \Infinityloop\Tests\Utils\NamedClassSet(dict[
            'x' => new \Infinityloop\Tests\Utils\NamedClass('x'),
            'y' => new \Infinityloop\Tests\Utils\NamedClass('y'),
            'z' => new \Infinityloop\Tests\Utils\NamedClass('z'),
        ]);

        $instance->merge($secondInstance);

        expect($instance->count())->toBeSame(6);
        expect($secondInstance->count())->toBeSame(3);
    }

    public function testMergeReplace(): void {
        $instance = new \Infinityloop\Tests\Utils\NamedClassSet(dict[
            'a' => new \Infinityloop\Tests\Utils\NamedClass('a'),
            'b' => new \Infinityloop\Tests\Utils\NamedClass('b'),
            'c' => new \Infinityloop\Tests\Utils\NamedClass('c'),
        ]);

        $secondInstance = new \Infinityloop\Tests\Utils\NamedClassSet(dict[
            'x' => new \Infinityloop\Tests\Utils\NamedClass('x'),
            'y' => new \Infinityloop\Tests\Utils\NamedClass('y'),
            'a' => new \Infinityloop\Tests\Utils\NamedClass('z'),
        ]);

        $instance->merge($secondInstance, true);

        expect(5)->toBeSame($instance->count());
        expect(3)->toBeSame($secondInstance->count());
    }

    public function testMergeNoReplace(): void {
        $instance = new \Infinityloop\Tests\Utils\NamedClassSet(dict[
            'a' => new \Infinityloop\Tests\Utils\NamedClass('a'),
            'b' => new \Infinityloop\Tests\Utils\NamedClass('b'),
            'c' => new \Infinityloop\Tests\Utils\NamedClass('c'),
        ]);

        $secondInstance = new \Infinityloop\Tests\Utils\NamedClassSet(dict[
            'x' => new \Infinityloop\Tests\Utils\NamedClass('x'),
            'y' => new \Infinityloop\Tests\Utils\NamedClass('y'),
            'a' => new \Infinityloop\Tests\Utils\NamedClass('z'),
        ]);

        expect(() ==> {
            $instance->merge($secondInstance);
        })->toThrow(\Infinityloop\Utils\Exception\ItemAlreadyExists::class);
    }
}
