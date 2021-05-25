namespace Slack\GraphQL\Pagination;

use namespace HH\Lib\{C, Vec};
use namespace Slack\GraphQL;

/**
 * Arguments passed to a connection's `paginate` method. These should be used to determine the result set.
 *
 * The framework ensures that at most one of `first` and `last` is provided.
 */
type PaginationArgs = shape(

    /**
     * If provided, only retrieve items which come before this cursor in the dataset.
     */
    ?'before' => string,

    /**
     * If provided, only retrieve items which come after this cursor in the dataset.
     */
    ?'after' => string,

    /**
     * If provided, only retrieve the first `first` items which appear after the `after` cursor or,
     * if the `after` cursor was not provided, after the first item in the dataset.
     */
    ?'first' => int,

    /**
     * If provided, only retrieve the last `last` items which appear before the `before` cursor or,
     * if the `before` cursor was not provided, before the last item in the dataset.
     */
    ?'last' => int,
);

/**
 * `Connection` provides a standard mechanism for slicing and paginating querysets, as well as for providing cursors
 * and informing the client when more results are available.
 *
 * Each connection must define a node type `TNode` over which it paginates. `TNode` must be a Hack type which has a
 * GraphQL representation that is not a list type. To paginate over a type `TNode`, subclass `Connection` and
 * implement the `TNode` type constand and the `fetch` method. While `Connection` is purposely simple so as to support 
 * a wide variety of data sources, you're encouraged to create reusable subclasses which connect to the data sources
 * you use.
 *
 * @see https://relay.dev/graphql/connections.htm for more information about GraphQL pagination.
 * @see src/playground/UserConnection.hack for an example.
 */
abstract class Connection {

    /**
     * Node type for this connection.
     *
     * This should be the Hack class over which you want to paginate.
     */
    abstract const type TNode;

    /**
     * Fetch the data set per the pagination args, which contain cursors and limits.
     *
     * For example, if the pagination args contain a `before` cursor with value `foo` and a `last` limit with value 5, 
     * `fetch` should return edges wrapping the 5 items immediately prior to the item with cursor `foo`.
     */
    abstract protected function fetch(PaginationArgs $args): Awaitable<vec<Edge<this::TNode>>>;

    /**
     * Encode a cursor before transmitting it to the client.
     *
     * By default, cursors are base64 encoded. Override this method to change that.
     */
    public function encodeCursor(string $cursor): string {
        return \base64_encode($cursor);
    }

    /**
     * Decode a cursor upon receiving it from the client.
     *
     * By default, cursors are base64 encoded. If you change that, you'll need to override this method.
     */
    public function decodeCursor(string $cursor): string {
        return \base64_decode($cursor);
    }

    /**
     * Whether a page exists before the `after` cursor, was such a cursor provided.
     * As this often cannot be determined efficiently, this method returns false by default.
     */
    public async function hasPageBeforeAfterCursor(string $after_cursor): Awaitable<bool> {
        return false;
    }

    /**
     * Whether a page exists after the `before` cursor, was such a cursor provided.
     * As this cannot often be determined efficiently, this method returns false by default.
     */
    public async function hasPageAfterBeforeCursor(string $before_cursor): Awaitable<bool> {
        return false;
    }

    //
    // Implementation Details
    //

    private PaginationArgs $args = shape();

    /**
     * Called by the framework to set pagination args immediately after receiving a connection from a resolver.
     *
     * These args are not passed to resolvers directly, so framework users need only handle them when implementing
     * the `paginate` method, and then after they've been coerced to the more amenable `PaginationArgs` shape.
     */
    public function setPaginationArgs(?string $after, ?string $before, ?int $first, ?int $last): this {
        $args = shape();

        if ($first is nonnull && $last is nonnull) {
            // We might relax this requirement at some point.
            // For now, handling both `first` and `last` at the same time is more trouble than it's worth.
            throw new GraphQL\UserFacingError('Only provide one of either "first" or "last".');
        } elseif ($first is nonnull) {
            if ($first < 0) {
                throw new GraphQL\UserFacingError('"first" must be a non-negative integer.');
            }
            // Always fetch an extra item so we can efficiently determine if there's a next page.
            $args['first'] = $first + 1;
        } elseif ($last is nonnull) {
            if ($last < 0) {
                throw new GraphQL\UserFacingError('"last" must be a non-negative integer.');
            }
            // Always fetch an extra item so we can efficiently determine if there's a prior page.
            $args['last'] = $last + 1;
        }

        // Decode cursors
        if ($after is nonnull) {
            $args['after'] = $this->decodeCursor($after);
        }
        if ($before is nonnull) {
            $args['before'] = $this->decodeCursor($before);
        }

        $this->args = $args;

        return $this;
    }

    /**
     * Constuct the correct edges and pageInfo objects from the result of calling the user-implemented `paginate` 
     * method with the pagination args.
     */
    <<__Memoize>>
    final private async function paginate(): Awaitable<shape(
        'edges' => vec<Edge<this::TNode>>,
        'pageInfo' => PageInfo
    )> {
        $page = await $this->fetch($this->args);

        $page_info = shape();

        // Determine whether more results are available by checking whether the number of items returned from
        // `paginate` is more than the number of items requested by the client. We always request one more item
        // than the client requested so as to simplify this calculation.

        $first = $this->args['first'] ?? null;
        if ($first is nonnull) {
            $page_info['hasNextPage'] = C\count($page) > $first - 1;
            if (Shapes::keyExists($this->args, 'after')) {
                $page_info['hasPreviousPage'] = await $this->hasPageBeforeAfterCursor($this->args['after']);
            }
            if ($page_info['hasNextPage']) {
                $page = Vec\take($page, $first - 1);
            }
        }

        $last = $this->args['last'] ?? null;
        if ($last is nonnull) {
            $page_info['hasPreviousPage'] = C\count($page) > $last - 1;
            if (Shapes::keyExists($this->args, 'before')) {
                $page_info['hasNextPage'] = await $this->hasPageAfterBeforeCursor($this->args['before']);
            }
            if ($page_info['hasPreviousPage']) {
                $page = Vec\drop($page, 1);
            }
        }

        // Set the start and end cursors if the query had results.
        if (!C\is_empty($page)) {
            $page_info['startCursor'] = C\firstx($page)->getCursor();
            $page_info['endCursor'] = C\lastx($page)->getCursor();
        }

        return shape('edges' => $page, 'pageInfo' => $page_info);
    }

    /**
     * Get edges containing nodes of type `T`.
     * This is the method invoked when querying the `edges` field on a connection.
     */
    final public async function getEdges(): Awaitable<vec<Edge<this::TNode>>> {
        $ret = await $this->paginate();
        return $ret['edges'];
    }

    /**
     * Get page info for this connection.
     * This is the method invoked when querying the `pageInfo` field on a connection.
     */
    final public async function getPageInfo(): Awaitable<PageInfo> {
        $ret = await $this->paginate();
        return $ret['pageInfo'];
    }
}
