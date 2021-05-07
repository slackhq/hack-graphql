namespace Generated;

use namespace Slack\GraphQL;
use namespace HH\Lib\Dict;

final abstract class Schema extends GraphQL\BaseSchema {
    public static async function resolveQuery(\Graphpinator\Parser\Operation\Operation $operation): Awaitable<mixed> {
        $query = new Query();

        $data = dict[];
        foreach ($operation->getFields()->getFields() as $field) { // TODO: ->getFragments()
            $data[$field->getName()] = self::resolveField($field, $query, null);
        }

        return await Dict\from_async($data);
    }
}

final class Query extends GraphQL\Types\ObjectType {
    const type THackType = null;

    public static async function resolveField(string $field_name, self::THackType $_): Awaitable<mixed> {
        switch ($field_name) {
            case 'viewer':
                return await \UserQueryAttributes::getViewer();
            default:
                throw new \Error('Unknown field: '.$field_name);
        }
    }

    public static function resolveType(string $field_name): GraphQL\Types\BaseType {
        switch ($field_name) {
            case 'viewer':
                return new User();
            default:
                throw new \Error('Unknown field: '.$field_name);
        }
    }
}

final class Team extends GraphQL\Types\ObjectType {
    const type THackType = \Team;

    public static async function resolveField(string $field_name, self::THackType $resolved_parent): Awaitable<mixed> {
        switch ($field_name) {
            case 'id':
                return $resolved_parent->getId();
            case 'name':
                return $resolved_parent->getName();
            default:
                throw new \Error('Unknown field: '.$field_name);
        }
    }

    public static function resolveType(string $field_name): GraphQL\Types\BaseType {
        switch ($field_name) {
            case 'id':
                return new GraphQL\Types\IntType();
            case 'name':
                return new GraphQL\Types\StringType();
            default:
                throw new \Error('Unknown field: '.$field_name);
        }
    }
}

final class User extends GraphQL\Types\ObjectType {
    const type THackType = \User;

    public static async function resolveField(string $field_name, self::THackType $resolved_parent): Awaitable<mixed> {
        switch ($field_name) {
            case 'id':
                return $resolved_parent->getId();
            case 'name':
                return $resolved_parent->getName();
            case 'team':
                return await $resolved_parent->getTeam();
            default:
                throw new \Error('Unknown field: '.$field_name);
        }
    }

    public static function resolveType(string $field_name): GraphQL\Types\BaseType {
        switch ($field_name) {
            case 'id':
                return new GraphQL\Types\IntType();
            case 'name':
                return new GraphQL\Types\StringType();
            case 'team':
                return new Team();
            default:
                throw new \Error('Unknown field: '.$field_name);
        }
    }
}
