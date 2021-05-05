namespace Generated;

final class Resolver {
    public static async function resolve(
        \Graphpinator\Parser\ParsedRequest $request,
    ): Awaitable<shape('data' => ?dict<string, mixed>, ?'errors' => vec<string>)> {
        // TODO: what does the spec say should actually be contained in the output?
        $out = shape('data' => dict[]);
        foreach ($request->getOperations() as $operation) {
            $data = dict[];
            foreach ($operation->getFields() as $field) {
                $data[$field->getName()] = await self::resolveField($field, null);
            }

            $out['data'][$operation->getType()] = $data;
        }

        return $out;
    }

    private static async function resolveField(
        \Graphpinator\Parser\Field\Field $field,
        mixed $parent,
    ): Awaitable<mixed> {
        $field_name = $field->getName();

        $resolved_type = null;
        $resolved_field = null;

        if ($parent is null) {
            $resolved_field = await Query::resolveField($field_name);
            $resolved_type = Query::resolveType($field_name);
        } else if ($parent is \User) {
            $resolved_field = await User::resolveField($field_name, $parent);
            $resolved_type = User::resolveType($field_name);
        } else if ($parent is \Team) {
            $resolved_field = await Team::resolveField($field_name, $parent);
            $resolved_type = Team::resolveType($field_name);
        }

        if ($resolved_type is \Types\GQLObject) {
            $child_data = dict[];
            foreach ($field->getFields() ?? vec[] as $child_field) {
                $child_data[$child_field->getName()] = await self::resolveField($child_field, $resolved_field);
            }
            return $child_data;
        }

        return $resolved_field;
    }
}

final abstract class Query {
    public static async function resolveField(string $field_name): Awaitable<mixed> {
        switch ($field_name) {
            case 'viewer':
                return await self::getViewer();
            default:
                throw new \Error('Unknown field: '.$field_name);
        }
    }

    public static function resolveType(string $field_name): \Types\Base {
        switch ($field_name) {
            case 'viewer':
                return new \Types\GQLObject();
            default:
                throw new \Error('Unknown field: '.$field_name);
        }
    }

    public static async function getViewer(): Awaitable<\User> {
        return new \User(shape('id' => 1, 'name' => 'Test User', 'team_id' => 1));
    }
}

final abstract class Team {
    public static async function resolveField(string $field_name, \Team $resolved_parent): Awaitable<mixed> {
        switch ($field_name) {
            case 'id':
                return $resolved_parent->getId();
            case 'name':
                return $resolved_parent->getName();
            default:
                throw new \Error('Unknown field: '.$field_name);
        }
    }

    public static function resolveType(string $field_name): \Types\Base {
        switch ($field_name) {
            case 'id':
                return new \Types\GQLInt();
            case 'name':
                return new \Types\GQLString();
            default:
                throw new \Error('Unknown field: '.$field_name);
        }
    }
}

final abstract class User {
    public static async function resolveField(string $field_name, \User $resolved_parent): Awaitable<mixed> {
        switch ($field_name) {
            case 'id':
                return $resolved_parent->getId();
            case 'name':
                return $resolved_parent->getName();
            case 'team':
                return $resolved_parent->getTeam();
            default:
                throw new \Error('Unknown field: '.$field_name);
        }
    }

    public static function resolveType(string $field_name): \Types\Base {
        switch ($field_name) {
            case 'id':
                return new \Types\GQLInt();
            case 'name':
                return new \Types\GQLInt();
            case 'team':
                return new \Types\GQLObject();
            default:
                throw new \Error('Unknown field: '.$field_name);
        }
    }
}
