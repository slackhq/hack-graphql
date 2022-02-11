

namespace Slack\GraphQL\Pagination;

use namespace HH\Lib\{C, Vec};
use namespace Slack\GraphQL;

/**
 * Arguments passed to a connection's `fetch` method. These should be used to determine the result set.
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
 * You can also add custom fields to a connection subclass by annotating methods with `Slack\GraphQL\Field`.
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
     * Can be overridden for efficiency.
     */
    protected async function hasNextPage(
        PaginationArgs $args,
        string $start_cursor,
        string $end_cursor,
    ): Awaitable<bool> {
        if (Shapes::keyExists($args, 'last') && !Shapes::keyExists($args, 'before')) {
            return false;
        }

        if (!Shapes::keyExists($args, 'first') && !Shapes::keyExists($args, 'before')) {
            return false;
        }

        return C\count(await $this->fetch(shape('first' => 1, 'after' => $end_cursor))) > 0;
    }

    /**
     * Whether a page exists after the `before` cursor, was such a cursor provided.
     * Can be overridden for efficiency.
     */
    protected async function hasPreviousPage(
        PaginationArgs $args,
        string $start_cursor,
        string $end_cursor,
    ): Awaitable<bool> {
        if (Shapes::keyExists($args, 'first') && !Shapes::keyExists($args, 'after')) {
            return false;
        }

        if (!Shapes::keyExists($args, 'last') && !Shapes::keyExists($args, 'after')) {
            return false;
        }

        return C\count(await $this->fetch(shape('last' => 1, 'before' => $start_cursor))) > 0;
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
    final public function setPaginationArgs(?string $after, ?string $before, ?int $first, ?int $last): this {
        $args = shape();

        if ($first is nonnull && $last is nonnull) {
            // We might relax this requirement at some point.
            // For now, handling both `first` and `last` at the same time is more trouble than it's worth.
            throw new GraphQL\UserFacingError('Only provide one of either "first" or "last".');
        } elseif ($first is nonnull) {
            if ($first < 0) {
                throw new GraphQL\UserFacingError('"first" must be a non-negative integer.');
            }

            $args['first'] = $first;
        } elseif ($last is nonnull) {
            if ($last < 0) {
                throw new GraphQL\UserFacingError('"last" must be a non-negative integer.');
            }

            $args['last'] = $last;
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
     * Constuct the correct edges and pageInfo objects from the result of calling the user-implemented `fetch` 
     * method with the pagination args.
     */
    <<__Memoize>>
    final private async function paginate(): Awaitable<shape(
        'edges' => vec<Edge<this::TNode>>,
        'pageInfo' => PageInfo,
    )> {
        $edges = await $this->fetch($this->args);

        $page_info = shape(
            'hasNextPage' => false,
            'hasPreviousPage' => false,
        );

        if (!C\is_empty($edges)) {
            $page_info['startCursor'] = C\firstx($edges)->getCursor();
            $page_info['endCursor'] = C\lastx($edges)->getCursor();
            $decoded_start_cursor = $this->decodeCursor($page_info['startCursor']);
            $decoded_end_cursor = $this->decodeCursor($page_info['endCursor']);
            $page_info['hasNextPage'] =
                await $this->hasNextPage($this->args, $decoded_start_cursor, $decoded_end_cursor);
            $page_info['hasPreviousPage'] =
                await $this->hasPreviousPage($this->args, $decoded_start_cursor, $decoded_end_cursor);
        }

        return shape('edges' => $edges, 'pageInfo' => $page_info);
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
