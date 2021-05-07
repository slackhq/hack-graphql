namespace Infinityloop\Tests\Utils;

use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;

final class ObjectSetTest extends \Facebook\HackTest\HackTest {
    public function testToVec(): void {
        $vec = (
            new \Infinityloop\Tests\Utils\EmptyClassSet(vec[
                new \Infinityloop\Tests\Utils\EmptyClass(),
                new \Infinityloop\Tests\Utils\EmptyClass(),
            ])
        )->toVec();

        expect(C\count($vec))->toBeSame(2);
    }

    public function testIterator(): void {
        $instance = new \Infinityloop\Tests\Utils\EmptyClassSet(vec[
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
        ]);

        $index = 0;

        foreach ($instance as $key => $value) {
            expect($index)->toBeSame($key);
            expect($value)->toBeInstanceOf(EmptyClass::class);

            ++$index;
        }

        $index = 0;

        foreach ($instance as $key => $value) {
            expect($index)->toBeSame($key);
            expect($value)->toBeInstanceOf(EmptyClass::class);

            ++$index;
        }
    }

    public function testCount(): void {
        $instance = new \Infinityloop\Tests\Utils\EmptyClassSet(vec[
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
        ]);

        expect(3)->toBeSame($instance->count());
    }

    public function testOffsetExists(): void {
        $instance = new \Infinityloop\Tests\Utils\EmptyClassSet(vec[
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
        ]);

        expect($instance->offsetExists(0))->toBeTrue();
        expect($instance->offsetExists(1))->toBeTrue();
        expect($instance->offsetExists(2))->toBeTrue();
        expect($instance->offsetExists(3))->toBeFalse();
    }

    public function testOffsetGet(): void {
        $instance = new \Infinityloop\Tests\Utils\EmptyClassSet(vec[
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
        ]);

        expect($instance->offsetGet(0))->toBeInstanceOf(EmptyClass::class);
        expect($instance->offsetGet(1))->toBeInstanceOf(EmptyClass::class);
        expect($instance->offsetGet(2))->toBeInstanceOf(EmptyClass::class);
    }

    public function testInvalidOffsetGet(): void {
        $instance = new \Infinityloop\Tests\Utils\EmptyClassSet(vec[
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
        ]);
        expect(() ==> {
            $instance->offsetGet(3);
        })->toThrow(\Infinityloop\Utils\Exception\UnknownOffset::class);
    }

    public function testOffsetSet(): void {
        $instance = new \Infinityloop\Tests\Utils\EmptyClassSet(vec[]);
        $instance->offsetSet(null, new \Infinityloop\Tests\Utils\EmptyClass());
        $instance->offsetSet(null, new \Infinityloop\Tests\Utils\EmptyClass());

        expect($instance->offsetExists(0))->toBeTrue();
        expect($instance->offsetExists(1))->toBeTrue();
    }

    public function testOffsetUnset(): void {
        $instance = new \Infinityloop\Tests\Utils\EmptyClassSet(vec[
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
        ]);

        expect($instance->count())->toBeSame(3);
        expect($instance->offsetExists(0))->toBeTrue();
        expect($instance->offsetExists(1))->toBeTrue();
        expect($instance->offsetExists(2))->toBeTrue();

        $instance->offsetUnset(1);
        expect($instance->count())->toBeSame(2);

        $instance->offsetUnset(1);
        expect($instance->count())->toBeSame(1);

        $instance->offsetUnset(0);
        expect($instance->count())->toBeSame(0);
    }

    public function testInvalidOffsetUnset(): void {
        $instance = new \Infinityloop\Tests\Utils\EmptyClassSet(vec[]);
        expect(() ==> {
            $instance->offsetUnset(0);
        })->toThrow(\Infinityloop\Utils\Exception\UnknownOffset::class);
    }

    public function testMerge(): void {
        $instance = new \Infinityloop\Tests\Utils\EmptyClassSet(vec[
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
        ]);

        $secondInstance = new \Infinityloop\Tests\Utils\EmptyClassSet(vec[
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
        ]);

        $instance->merge($secondInstance);

        expect($instance->count())->toBeSame(6);
        expect($secondInstance->count())->toBeSame(3);
    }

    public function testMergeReplace(): void {
        $instance = new \Infinityloop\Tests\Utils\EmptyClassSet(vec[
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
        ]);

        $secondInstance = new \Infinityloop\Tests\Utils\EmptyClassSet(vec[
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
            new \Infinityloop\Tests\Utils\EmptyClass(),
        ]);

        $instance->merge($secondInstance, true);

        expect($instance->count())->toBeSame(3);
        expect($secondInstance->count())->toBeSame(3);
    }
}
