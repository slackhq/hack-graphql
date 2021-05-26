use namespace Slack\GraphQL;

use namespace HH\Lib\C;
use function Facebook\FBExpect\expect;

final class IntrospectionTest extends PlaygroundTest {

    <<__Override>>
    public static function getTestCases(): this::TTestCases {
        return dict[
            'validate input fields' => tuple(
                '{
                    __type(name: "IntrospectionRootInput") {
                        inputFields {
                            name
                            type {
                                kind
                                name
                                ofType {
                                    kind
                                    name
                                    ofType {
                                        kind
                                        name
                                    }
                                }
                            }
                        }
                    }
                }',
                dict[],
                dict[
                    '__type' => dict[
                        'inputFields' => vec[
                            dict[
                                'name' => 'scalar',
                                'type' => dict[
                                    'kind' => 'SCALAR',
                                    'name' => 'String',
                                    'ofType' => null,
                                ],
                            ],
                            dict[
                                'name' => 'nested',
                                'type' => dict[
                                    'kind' => 'INPUT_OBJECT',
                                    'name' => 'IntrospectionNestedInput',
                                    'ofType' => null,
                                ],
                            ],
                            dict[
                                'name' => 'vec_of_nested_non_nullable',
                                'type' => dict[
                                    'kind' => 'LIST',
                                    'name' => null,
                                    'ofType' => dict[
                                        'kind' => 'NON_NULL',
                                        'name' => null,
                                        'ofType' => dict[
                                            'kind' => 'INPUT_OBJECT',
                                            'name' => 'IntrospectionNestedInput',
                                        ],
                                    ],
                                ],
                            ],
                            dict[
                                'name' => 'vec_of_nested_nullable',
                                'type' => dict[
                                    'kind' => 'LIST',
                                    'name' => null,
                                    'ofType' => dict[
                                        'kind' => 'INPUT_OBJECT',
                                        'name' => 'IntrospectionNestedInput',
                                        'ofType' => null,
                                    ],
                                ],
                            ],
                            dict[
                                'name' => 'non_nullable',
                                'type' => dict[
                                    'kind' => 'NON_NULL',
                                    'name' => null,
                                    'ofType' => dict[
                                        'kind' => 'SCALAR',
                                        'name' => 'String',
                                        'ofType' => null,
                                    ],
                                ],
                            ],
                        ],
                    ],
                ],
            ),
            'validate enum values' => tuple(
                '{
                    __type(name: "IntrospectionEnum") {
                        enumValues {
                            name
                            description
                            isDeprecated
                            deprecationReason
                        }
                    }
                 }',
                dict[],
                dict[
                    '__type' => dict[
                        'enumValues' => vec[
                            dict[
                                'name' => 'A',
                                'description' => null,
                                'isDeprecated' => false,
                                'deprecationReason' => null,
                            ],
                            dict[
                                'name' => 'B',
                                'description' => null,
                                'isDeprecated' => false,
                                'deprecationReason' => null,
                            ],
                        ],
                    ],
                ],
            ),
            'validate interface introspection with extended interface' => tuple(
                '{
                    __type(name: "IIntrospectionInterfaceA") {
                        possibleTypes {
                            name
                        }
                    }
                 }',
                dict[],
                dict[
                    '__type' => dict[
                        'possibleTypes' => vec[
                            dict[
                                'name' => 'ImplementInterfaceA',
                            ],
                            dict[
                                'name' => 'ImplementInterfaceB',
                            ],
                            dict[
                                'name' => 'ImplementInterfaceC',
                            ],
                        ],
                    ],
                ],
            ),
            'validate interface introspection' => tuple(
                '{
                    __type(name: "IIntrospectionInterfaceC") {
                        possibleTypes {
                            name
                        }
                    }
                 }',
                dict[],
                dict[
                    '__type' => dict[
                        'possibleTypes' => vec[
                            dict[
                                'name' => 'ImplementInterfaceC',
                            ],
                        ],
                    ],
                ],
            ),
            'validate object introspection with multiple interfaces' => tuple(
                '{
                    __type(name: "ImplementInterfaceC") {
                        interfaces {
                            name
                        }
                    }
                }',
                dict[],
                dict[
                    '__type' => dict[
                        'interfaces' => vec[
                            dict[
                                'name' => 'IIntrospectionInterfaceA',
                            ],
                            dict[
                                'name' => 'IIntrospectionInterfaceB',
                            ],
                            dict[
                                'name' => 'IIntrospectionInterfaceC',
                            ],
                        ],
                    ],
                ],
            ),
            'validate object introspection with a single interface' => tuple(
                '{
                    __type(name: "ImplementInterfaceA") {
                        interfaces {
                            name
                        }
                    }
                }',
                dict[],
                dict[
                    '__type' => dict[
                        'interfaces' => vec[
                            dict[
                                'name' => 'IIntrospectionInterfaceA',
                            ],
                        ],
                    ],
                ],
            ),
            'validate object introspection with no interfaces' => tuple(
                '{
                    __type(name: "IntrospectionTestObject") {
                        interfaces {
                            name
                        }
                    }
                }',
                dict[],
                dict[
                    '__type' => dict[
                        'interfaces' => vec[],
                    ],
                ],
            ),
            'select the name of the query type' => tuple(
                '{
                    __schema {
                        queryType {
                            kind
                            name
                        }
                        mutationType {
                            kind
                            name
                        }
                    }
                    __type(name: "Query") {
                        kind
                        name
                    }
                }',
                dict[],
                dict[
                    '__schema' => dict[
                        'queryType' => dict[
                            'kind' => 'OBJECT',
                            'name' => 'Query',
                        ],
                        'mutationType' => dict[
                            'kind' => 'OBJECT',
                            'name' => 'Mutation',
                        ],
                    ],
                    '__type' => dict[
                        'kind' => 'OBJECT',
                        'name' => 'Query',
                    ],
                ],
            ),
            'validate field introspection' => tuple(
                '{
                    __type(name: "IntrospectionTestObject") {
                        name
                        fields {
                            name
                            type {
                                kind
                                name
                                ofType {
                                    kind
                                    name
                                    ofType {
                                        kind
                                        name
                                        ofType {
                                            kind
                                            name
                                        }
                                    }
                                }
                            }
                        }
                    }
                }',
                dict[],
                dict[
                    '__type' => dict[
                        'name' => 'IntrospectionTestObject',
                        'fields' => vec[
                            dict[
                                'name' => 'default_list_of_non_nullable_int',
                                'type' => dict[
                                    'kind' => 'LIST',
                                    'name' => null,
                                    'ofType' => dict[
                                        'kind' => 'NON_NULL',
                                        'name' => null,
                                        'ofType' => dict[
                                            'kind' => 'SCALAR',
                                            'name' => 'Int',
                                            'ofType' => null,
                                        ],
                                    ],
                                ],
                            ],
                            dict[
                                'name' => 'default_list_of_nullable_int',
                                'type' => dict[
                                    'kind' => 'LIST',
                                    'name' => null,
                                    'ofType' => dict[
                                        'kind' => 'SCALAR',
                                        'name' => 'Int',
                                        'ofType' => null,
                                    ],
                                ],
                            ],
                            dict[
                                'name' => 'default_nullable_string',
                                'type' => dict[
                                    'kind' => 'SCALAR',
                                    'name' => 'String',
                                    'ofType' => null,
                                ],
                            ],
                            dict[
                                'name' => 'non_null_int',
                                'type' => dict[
                                    'kind' => 'NON_NULL',
                                    'name' => null,
                                    'ofType' => dict[
                                        'kind' => 'SCALAR',
                                        'name' => 'Int',
                                        'ofType' => null,
                                    ],
                                ],
                            ],
                            dict[
                                'name' => 'non_null_list_of_non_null',
                                'type' => dict[
                                    'kind' => 'NON_NULL',
                                    'name' => null,
                                    'ofType' => dict[
                                        'kind' => 'LIST',
                                        'name' => null,
                                        'ofType' => dict[
                                            'kind' => 'NON_NULL',
                                            'name' => null,
                                            'ofType' => dict[
                                                'kind' => 'SCALAR',
                                                'name' => 'Int',
                                            ],
                                        ],
                                    ],
                                ],
                            ],
                            dict[
                                'name' => 'non_null_string',
                                'type' => dict[
                                    'kind' => 'NON_NULL',
                                    'name' => null,
                                    'ofType' => dict[
                                        'kind' => 'SCALAR',
                                        'name' => 'String',
                                        'ofType' => null,
                                    ],
                                ],
                            ],
                            dict[
                                'name' => 'nullable_string',
                                'type' => dict[
                                    'kind' => 'SCALAR',
                                    'name' => 'String',
                                    'ofType' => null,
                                ],
                            ],
                        ],
                    ],
                ],
            ),
        ];
    }

    public async function testIntrospectionQuery(): Awaitable<void> {
        $results = await $this->resolve(GraphQL\Introspection\Utilities::getIntrospectionQuery());
        // TODO: would be great to use something like:
        // https://github.com/hhvm/hack-codegen/blob/master/tests/TestLib/ExpectObj.hack#L22
        \file_put_contents(__DIR__.'/gen/schema.json', \json_encode($results, \JSON_PRETTY_PRINT));
    }
}
