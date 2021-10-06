


use namespace Slack\GraphQL;
use namespace HH\Lib\{Math, Str};

final class UserConnection extends GraphQL\Pagination\Connection {
    const type TNode = User;

    public function __construct(private string $name_prefix = 'User') {}

    <<GraphQL\Field('totalCount', 'Total number of users')>>
    public async function getTotalCount(): Awaitable<int> {
        return 5;
    }

    protected async function fetch(
        GraphQL\Pagination\PaginationArgs $args,
    ): Awaitable<vec<GraphQL\Pagination\Edge<User>>> {
        $after = $args['after'] ?? null;
        $start_id = 0;
        if ($after) {
            $start_id = Str\to_int($after) as nonnull + 1; // Add one to skip the `after` cursor.
        }

        $before = $args['before'] ?? null;
        $end_id = 5;
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
            $edges[] = new GraphQL\Pagination\Edge(
                new Human(shape(
                    'id' => $i,
                    'name' => $this->name_prefix.' '.$i,
                    'team_id' => 1,
                    'is_active' => $i % 2 === 0 ? true : false,
                )),
                $this->encodeCursor((string)$i),
            );
        }

        return $edges;
    }
}
