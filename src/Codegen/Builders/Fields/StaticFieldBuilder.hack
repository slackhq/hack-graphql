namespace Slack\GraphQL\Codegen;

class StaticFieldBuilder extends MethodFieldBuilder {
    <<__Override>>
    protected function getMethodCallPrefix(): string {
        $class = $this->reflection_method->getDeclaringClass();
        return '\\'.$class->getName().'::';
    }
}
