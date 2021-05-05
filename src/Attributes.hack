class GraphQLObject implements \HH\ClassAttribute {
    public function __construct(private string $type, private string $description) {}
}

class GraphQLField implements \HH\MethodAttribute {
    public function __construct(private string $name, private string $description) {}
}

class GraphQLQueryRootField implements \HH\MethodAttribute {
    public function __construct(private string $name, private string $description) {}
}
