namespace Generated;

final class Resolver {
    public static function resolve(
        \Graphpinator\Parser\ParsedRequest $request,
    ): shape('data' => ?dict<string, mixed>, ?'errors' => vec<string>) {
        $out = shape('data' => dict[]);
        foreach ($request->getOperations() as $operation) {
            $data = dict[];
            foreach ($operation->getFields() as $field) {
                self::resolveField($field, null, inout $data);
            }

            $out['data'][$operation->getType()] = $data;
        }

        return $out;
    }

    private static function resolveField(
        \Graphpinator\Parser\Field\Field $field,
        mixed $parent,
        inout dict<string, mixed> $data,
    ): void {
        $field_name = $field->getName();

        $resolved_type = null;
        $resolved_field = null;

        if ($parent is null) {
            $resolved_field = Query::resolveField($field_name);
            $resolved_type = Query::resolveType($field_name);
        } else if ($parent is \User) {
            $resolved_field = User::resolveField($field_name, $parent);
            $resolved_type = User::resolveType($field_name);
        } else if ($parent is \Team) {
            $resolved_field = Team::resolveField($field_name, $parent);
            $resolved_type = Team::resolveType($field_name);
        }

        if ($resolved_type is \Types\GQLObject) {
            $child_data = dict[];
            foreach ($field->getFields() ?? vec[] as $child_field) {
                self::resolveField($child_field, $resolved_field, inout $child_data);
            }
            $data[$field_name] = $child_data;
        } else {
            $data[$field_name] = $resolved_field;
        }
    }
}

final abstract class Query {
    public static function resolveField(string $field_name): mixed {
        switch ($field_name) {
            case 'viewer':
                return self::getViewer();
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

    public static function getViewer(): \User {
        return new \User(shape('id' => 1, 'name' => 'Test User', 'team_id' => 1));
    }
}

final abstract class Team {
    public static function resolveField(string $field_name, \Team $resolved_parent): mixed {
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
    public static function resolveField(string $field_name, \User $resolved_parent): mixed {
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
