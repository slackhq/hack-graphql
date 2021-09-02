
namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\Vec;
use namespace Facebook\DefinitionFinder;

/**
 * Parser which allows for aggregating a set of parsers and operating them in unison.
 */
final class MultiParser {
    public function __construct(private vec<DefinitionFinder\BaseParser> $parsers) {}

    private function mapParsers<T>((function(DefinitionFinder\BaseParser): vec<T>) $cb): vec<T> {
        return Vec\map($this->parsers, $parser ==> $cb($parser)) |> Vec\flatten($$);
    }

    public function getTypes(): vec<DefinitionFinder\ScannedType> {
        return $this->mapParsers($parser ==> $parser->getTypes());
    }

    public function getClasses(): vec<DefinitionFinder\ScannedClass> {
        return $this->mapParsers($parser ==> $parser->getClasses());
    }

    public function getInterfaces(): vec<DefinitionFinder\ScannedInterface> {
        return $this->mapParsers($parser ==> $parser->getInterfaces());
    }

    public function getEnums(): vec<DefinitionFinder\ScannedEnum> {
        return $this->mapParsers($parser ==> $parser->getEnums());
    }

    public function getClassishObjects(): vec<DefinitionFinder\ScannedClassish> {
        return Vec\concat($this->getClasses(), $this->getInterfaces());
    }
}
