namespace Graphpinator\Exception\Upload;

abstract class UploadError extends \Graphpinator\Exception\GraphpinatorBase
{
    public function isOutputable() : bool
    {
        return true;
    }
}
