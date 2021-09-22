# hack-graphql

Hack-GraphQL is the first (and currently only) open-source [GraphQL](https://graphql.org/) server written in [Hack](https://hacklang.org/). It provides a developer-first approach to declaring a GraphQL schema as Hack code, using attributes and code generation. While not yet fully-featured, Hack-GraphQL supports most of the GraphQL spec.

## Features
* Code-first approach: declare GraphQL types and fields as Hack code.
* Strongly typed: generated code is 100% type-safe.
* Supports nearly all GraphQL types: objects, interfaces, enumerations, directives, lists, and input objects.
* Support for introspection.
* Ships with support for the [Relay model of pagination](https://relay.dev/graphql/connections.htm).

### Missing Features
* Subscriptions
* Only a subset of GraphQL's validation rules are implemented. To see which rules have been implemented, take a look at the `src/Validation/Rules` directory.
* It is not possible to declare custom directives. Only the `include` and `skip` directives are supported.
* No support for unions (because Hack does not support them).

## Usage

In Hack-GraphQL, we represent GraphQL types and fields as ordinary Hack classes and methods. To create a new GraphQL type, we declare a Hack class and annotate it with the `<<GraphQL\ObjectType>>` attribute. To add a field to the type, we add a method annotated with `<<GraphQL\Field>>` to the Hack class.

For example, here's how we might declare a type called "User" with a "name" field:

```hack
use namespace Slack\GraphQL;

<<GraphQL\ObjectType('User', 'A user of our app')>>
final class User {
    public function __construct(private string $name) {}

    <<GraphQL\Field('name', 'The name of the user')>>
    public function getName(): string {
        return $this->name;
    }
}
```

Hack-GraphQL supports all GraphQL types except unions. See [Attributes](###Attributes) for details on generating instances of each type from Hack code.

Now we need to expose a top-level query which can retrieve our new type:

```hack
// This could be called anything - it's just a static
// class which contains the top-level query methods.
final class QueryFields {
    <<GraphQL\QueryRootField('getUser', 'Get the user')>>
    public static function getUser(string $name): User {
        return new User($name);
    }
}
```

Once you've defined your types, you'll run Hack-GraphQL's code generator to create resolvers for them:

```hack
use namespace Slack\GraphQL;

await GraphQL\Codegen\Generator::forPath(
    '/path/to/your/user/defined/types',
    shape(
        'output_directory' => '/path/for/your/generated/code',
        'namespace' => 'Generated',
    ),
);
```

Running the above code will write resolvers for the types defined in `/path/to/your/user/defined/types` to the `/path/for/your/generated/code` directory. These resolvers are generated code — you are *not* meant to edit them.

Hack-GraphQL will also generate a top-level `Schema` type which you can use to resolve queries and mutations, as follows:

```hack
use namespace Slack\GraphQL;

$resolver = new GraphQL\Resolver(new Generated\Schema());
$response = await $resolver->resolve($query);
```

In the above:
* `GraphQL\Resolver` is a class provided by Hack-GraphQL which handles resolving queries and mutations using the generated schema.
* `$query` is the string representation of a GraphQL query. The resolver will parse the query, validate it, and then use the schema to resolve it.
* `$response` is a shape containing data, errors, and extension fields, as required by [the GraphQL spec](https://spec.graphql.org/June2018/#sec-Response-Format).

And that's it! You're now ready to serve GraphQL queries and mutations using your new schema.

### Attributes

Hack-GraphQL exposes the following attributes which can be used to create GraphQL types and fields:

#### ObjectType

This attribute annotates a non-abstract class to declare a [GraphQL object](https://spec.graphql.org/June2018/#sec-Objects):

```hack
use namespace Slack\GraphQL;

<<GraphQL\ObjectType('User', 'A user of our app')>>
final class User {
    <<GraphQL\Field('name', 'Name of the user')>>
    public function getName(): string {
        return 'Steve';
    }
}
```

Note you may also declare GraphQL types by annotating Hack shapes with `ObjectType`. This can be a convenient shorthand:

```hack
<<GraphQL\ObjectType('User', 'A user of our app')>>
type User = shape(
    'name' => string,
);
```

The disadvantage of annotating shapes in this way is that they don't currently support descriptions of their fields. This is something we'd like to address.

#### Field

This attribute declares a GraphQL field by annotating a non-static method on a class or interface annotated with `GraphQL\ObjectType` or `GraphQL\InterfaceType`:

```hack
use namespace Slack\GraphQL;

<<GraphQL\ObjectType('User', 'A user of our app')>>
final class User {
    <<GraphQL\Field('name', 'Name of the user')>>
    public function getName(): string {
        return 'Steve';
    }

    <<GraphQL\Field('age', 'Age of the user')>>
    public function getAge(): int {
        return 45;
    }
}
```

#### QueryRootField

This attribute declares a GraphQL query by annotating a static method on any class:

```hack
use namespace Slack\GraphQL;

final class QueryFields {
    <<GraphQL\QueryRootField('user', 'Retrive a user by its name.')>>
    public static async function getUserByName(string $name): Awaitable<?User> {
        return await User::fetchByName($name);
    }
}
```

A GraphQL query written against this field might look like:

```graphql
{
    user(name: 'Steve') {
        age
        favoriteColor
    }
}
```

#### MutationRootField

This attribute declares a GraphQL mutation by annotating a static method on any class:

```hack
use namespace Slack\GraphQL;

final class MutationFields {
    <<GraphQL\MutationRootField('createUser', 'Create a user')>>
    public static async function createUser(string $name): Awaitable<?User> {
        return await User::create($name);
    }
}
```

A GraphQL mutation written against this field might look like:

```graphql
{
    createUser(name: 'Steve') {
        id
    }
}
```

#### InterfaceType
This attribute annotates an abstract class or interface to declare a GraphQL interface:

```hack
use namespace Slack\GraphQL;

<<GraphQL\InterfaceType('Character', 'A character in a film')>>
interface Character {
    <<GraphQL\Field('Name', 'Name of the character')>>
    public function getName(): string;
}

<<GraphQL\ObjectType('Wizard', 'A wizard')>>
final class Wizard implements Character {
    public function getName(): string {
        return 'Gandalf';
    }
}
```

In the above example, `Wizard` is a GraphQL object which implement the `Character` interface. This allows for queries like:

```graphql
{
    allCharacters {
        __typename
        name
    }
}
```

In the above schema, this query might output a response like:

```hack
shape(
    'data' => dict[
        'allCharacters' => vec[
            dict[
                '__typename' => 'Wizard',
                'name' => 'Gandalf',
            ],
        ],
    ],
    'errors' => vec[],
);
```

#### EnumType

This attribute annotates an enumeration to declare a GraphQL enum type:

```hack
<<GraphQL\EnumType('Colors', 'Available colors')>>
enum Colors: string {
    RED = 'RED';
    BLUE = 'BLUE';
    GREEN = 'GREEN';
}
```

#### InputObjectType

This attribute annotates a GraphQL shape as input to a GraphQL field:

```hack
<<GraphQL\InputObjectType('CreateUserInput', 'input args for creating a new user')>>
type CreateUserInput = shape(
    'name' => string,
    'age' => int,
    'email' => string,
);
```

You can then use this input object as an argument:

```hack
final class MutationFields {
    <<GraphQL\MutationRootField('CreateUser', 'Create a new user')>>
    public static async function createUser(CreateUserInput $input): Awaitable<User> {
       return await User::create($input['name'], $input['age'], $input['email']);
    }
}
```

### Exceptions

In GraphQL, fields which fail to be resolved can either be marked null in the response, or can "bubble-up" and cause their parent fields to be marked null as well. By default, Hack-GraphQL implements the first behavior: any field which throws an error during resolution will simply be null in the response. If the field throws an instance of `GraphQL\UserFacingError`, then an error will be added to the list of `errors` in the response from the resolver.

For example, say I have a schema like the following:

```graphql
type Query {
    user(name: String!): User
}

type User {
    name: String
    age: Int
}
```

Now, say that the resolver for the `name` field on `User` throws an error. Only the `name` field will be nulled out, and I will still get data for the `age` field.

To change this behavior, I can annotate the `name` field with the `KillsParentOnException` attribute:

```hack
<<GraphQL\Field('name', 'Name of the user'), GraphQL\KillsParentOnException>>
public function getName(): string {
    throw new GraphQL\UserFacingError("Invalid!");
}
```

Now the entire `User` object will be null in the response.

## Contributing

We welcome contributions to Hack-GraphQL. We do much of our discussion in #hack-graphql channel in the Hacklang Slack group; for an invite, fill out [this form](https://docs.google.com/forms/d/e/1FAIpQLSeiFTB1ppOMce2HxAuU_-qUvupalEpClT6lyKLexq-TPvua9w/viewform).