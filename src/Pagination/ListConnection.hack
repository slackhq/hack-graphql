namespace Slack\GraphQL\Pagination;

use namespace HH\Lib\{C, Math, Str};

abstract class ListConnection extends Connection {
    public function __construct(private vec<this::TNode> $items) {}

    public async function fetch(PaginationArgs $args): Awaitable<vec<Edge<this::TNode>>> {
        $start_id = 0;
        $end_id = C\count($this->items);

        $after = $args['after'] ?? null;
        if ($after) {
            $start_id = Str\to_int($after) as nonnull + 1; // Add one to skip the `after` cursor.
        }

        $before = $args['before'] ?? null;
        if ($before) {
            $end_id = Str\to_int($before) as nonnull;
        }

        $first = $args['first'] ?? null;
        if ($first) {
            $end_id = Math\minva($end_id, $start_id + $first);
        }

        $last = $args['last'] ?? null;
        if ($last) {
            $start_id = Math\maxva($start_id, $end_id - $last);
        }

        $edges = vec[];
        for ($i = $start_id; $i < $end_id; $i++) {
            $edges[] = new Edge($this->items[$i], $this->encodeCursor((string)$i));
        }
        return $edges;
    }
}