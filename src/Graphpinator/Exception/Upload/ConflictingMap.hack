namespace Graphpinator\Exception\Upload;

final class ConflictingMap extends \Graphpinator\Exception\Upload\UploadError {
    public function __construct() {
        parent::__construct('Upload map is in conflict with other value.');
    }
}
