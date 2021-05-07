namespace Graphpinator\Exception\Upload;

final class InvalidMap extends \Graphpinator\Exception\Upload\UploadError {
    public function __construct() {
        $message = 'Invalid map - invalid file map provided in multipart request.';
        parent::__construct($message);
    }
}
