namespace Graphpinator\Directive;

enum TypeSystemDirectiveLocation: string as string {
    SCHEMA = 'SCHEMA'; // currently not supported
    SCALAR = 'SCALAR'; // currently not supported
    UNION = 'UNION'; // currently not supported
    ENUM = 'ENUM'; // currently not supported
    OBJECT = 'OBJECT';
    INTERFACE = 'INTERFACE';
    INPUT_OBJECT = 'INPUT_OBJECT';
    FIELD_DEFINITION = 'FIELD_DEFINITION';
    ARGUMENT_DEFINITION = 'ARGUMENT_DEFINITION';
    INPUT_FIELD_DEFINITION = 'INPUT_FIELD_DEFINITION';
    ENUM_VALUE = 'ENUM_VALUE';
}
