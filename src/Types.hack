namespace Types;

abstract class Base {}

final class GQLObject extends Base {}

final class GQLString extends Base {}

// TODO: Int/String seem like reserved keywords? Not sure if there is a way to define them within the keyspace
final class GQLInt extends Base {}
