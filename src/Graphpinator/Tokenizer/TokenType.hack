namespace Graphpinator\Tokenizer;

final class TokenType {

    const NEWLINE = 'newline';
    const COMMENT = '#';
    const COMMA = ',';
    // lexical
    const NAME = 'name';
    const VARIABLE = '$';
    const DIRECTIVE = '@';
    const INT = 'int literal';
    const FLOAT = 'float literal';
    const STRING = 'string literal';
    // keywords
    const NULL = 'null';
    const TRUE = 'true';
    const FALSE = 'false';
    const string QUERY = OperationType::QUERY;
    const string MUTATION = OperationType::MUTATION;
    const string SUBSCRIPTION = OperationType::SUBSCRIPTION;
    const FRAGMENT = 'fragment';
    const ON = 'on'; // type condition
    // type system keywords
    const SCHEMA = 'schema';
    const TYPE = 'type';
    const INTERFACE = 'interface';
    const UNION = 'union';
    const INPUT = 'input';
    const ENUM = 'enum';
    const SCALAR = 'scalar';
    const IMPLEMENTS = 'implements';
    const REPEATABLE = 'repeatable';
    // punctators
    const AMP = '&'; // implements
    const PIPE = '|'; // union
    const EXCL = '!'; // not null
    const PAR_O = '('; // argument, variable, directive
    const PAR_C = ')';
    const CUR_O = '{'; // selection set
    const CUR_C = '}';
    const SQU_O = '['; // list
    const SQU_C = ']';
    const ELLIP = '...'; // fragment spread
    const COLON = ':'; // argument, variable, directive, field alias
    const EQUAL = '='; // default value

    const dict<string, bool> IGNORABLE = dict[
        self::COMMA => true,
        self::COMMENT => true,
        self::NEWLINE => true,
    ];
}
