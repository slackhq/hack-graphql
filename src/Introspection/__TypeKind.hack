
namespace Slack\GraphQL\Introspection;

use Slack\GraphQL;

<<GraphQL\EnumType('__TypeKind', '__TypeKind')>>
enum __TypeKind: string {
    SCALAR = 'SCALAR';
    OBJECT = 'OBJECT';
    INTERFACE = 'INTERFACE';
    UNION = 'UNION';
    ENUM = 'ENUM';
    INPUT_OBJECT = 'INPUT_OBJECT';
    LIST = 'LIST';
    NON_NULL = 'NON_NULL';
}
