


namespace Slack\GraphQL\Pagination;

use namespace Slack\GraphQL;

<<GraphQL\ObjectType('PageInfo', 'Info about the pagination state.')>>
type PageInfo = shape(

    /**
     * The first cursor in the dataset returned to the client.
     */
    ?'startCursor' => string,

    /**
     * The last cursor in the dataset returned to the client.
     */
    ?'endCursor' => string,

    /**
     * Whether at least one cursor exists prior to the `startCursor`.
     */
    ?'hasPreviousPage' => bool,

    /**
     * Whether at least one cursor exists after the `endCursor`.
     */
    ?'hasNextPage' => bool,
);
