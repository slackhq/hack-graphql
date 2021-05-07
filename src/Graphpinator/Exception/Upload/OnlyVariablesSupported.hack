namespace Graphpinator\Exception\Upload;

final class OnlyVariablesSupported extends \Graphpinator\Exception\Upload\UploadError {
    public function __construct() {
        $message = 'Files must be passed to variables.';
        parent::__construct($message);
    }
}
