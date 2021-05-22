namespace Slack\GraphQL\Pagination;

/**
 * Wraps an instance of a Hack type which has a non-list GraphQL representation, providing access to the underlying
 * instance as well as to the cursor identifying the instance in the dataset.
 */
class Edge<T> {

    public function __construct(private T $node, private string $cursor) {}

    /**
     * Get the node pointed to by this edge.
     * This is the method invoked when querying the `node` field on a GraphQL edge.
     */
    public function getNode(): T {
        return $this->node;
    }

    /**
     * Get the cursor identifying the node wrapped by this edge.
     * This is the method invoked when querying the `cursor` field on a GraphQL edge.
     */
    public function getCursor(): string {
        return $this->cursor;
    }
}
