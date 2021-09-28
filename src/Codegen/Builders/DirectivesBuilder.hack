


namespace Slack\GraphQL\Codegen;

use namespace HH\Lib\Str;
use type Facebook\HackCodegen\HackBuilder;

trait DirectivesBuilder {
    protected dict<string, vec<string>> $directives;

    protected function buildDirectives(HackBuilder $hb): HackBuilder {
        if ($this->directives) {
            $hb->addLine('vec[')
                ->indent();
            foreach ($this->directives as $directive => $arguments) {
                $hb->addLinef('new \%s(%s),', $directive, Str\join($arguments, ', '));
            }
            $hb->unindent()->add(']');
        } else {
            $hb->add('vec[]');
        }
        return $hb;
    }
}
