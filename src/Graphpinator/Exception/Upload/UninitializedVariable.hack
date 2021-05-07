namespace Graphpinator\Exception\Upload;

final class UninitializedVariable extends \Graphpinator\Exception\Upload\UploadError {
    public function __construct() {
        $message = 'Variable for Upload must be initialized.';
        parent::__construct($message);
    }
}
