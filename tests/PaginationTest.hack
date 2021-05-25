use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

/**
 * Test GraphQL pagination
 */
final class PaginationTest extends PlaygroundTest {

    <<__Override>>
    public static function getTestCases(): this::TTestCases {
        return dict[
            'test retrieving edges after an index' => tuple(
                'query ($after: String!) {
                    human(id: 20) {
                        friends(after: $after, first: 2) {
                            edges {
                                node {
                                    id
                                    name
                                }
                                cursor
                            }
                            pageInfo {
                                hasNextPage
                                startCursor
                                endCursor
                            }
                        }
                    }
                }',
                dict['after' => base64_encode("1")],
                dict[
                    'human' => dict[
                        'friends' => dict[
                            'edges' => vec[
                                dict[
                                    'node' => dict[
                                        'id' => 2,
                                        'name' => 'User 2',
                                    ],
                                    'cursor' => base64_encode('2'),
                                ],
                                dict[
                                    'node' => dict[
                                        'id' => 3,
                                        'name' => 'User 3',
                                    ],
                                    'cursor' => base64_encode('3'),
                                ],
                            ],
                            'pageInfo' => dict[
                                'hasNextPage' => true,
                                'startCursor' => base64_encode('2'),
                                'endCursor' => base64_encode('3'),
                            ]
                        ]
                    ]
                ]
            ),

            'test retrieving the last edges in the dataset' => tuple(
                'query ($after: String!) {
                    human(id: 20) {
                        friends(after: $after, first: 2) {
                            edges {
                                node {
                                    id
                                    name
                                }
                                cursor
                            }
                            pageInfo {
                                hasNextPage
                                startCursor
                                endCursor
                            }
                        }
                    }
                }',
                dict['after' => base64_encode("3")],
                dict[
                    'human' => dict[
                        'friends' => dict[
                            'edges' => vec[
                                dict[
                                    'node' => dict[
                                        'id' => 4,
                                        'name' => 'User 4',
                                    ],
                                    'cursor' => base64_encode('4'),
                                ],
                            ],
                            'pageInfo' => dict[
                                'hasNextPage' => false,
                                'startCursor' => base64_encode('4'),
                                'endCursor' => base64_encode('4'),
                            ],
                        ],
                    ],
                ],
            ),

            'test retrieving edges before an index' => tuple(
                'query ($before: String!) {
                    human(id: 20) {
                        friends(before: $before, last: 2) {
                            edges {
                                node {
                                    id
                                    name
                                }
                                cursor
                            }
                            pageInfo {
                                hasPreviousPage
                                startCursor
                                endCursor
                            }
                        }
                    }
                }',
                dict['before' => base64_encode("4")],
                dict[
                    'human' => dict[
                        'friends' => dict[
                            'edges' => vec[
                                dict[
                                    'node' => dict[
                                        'id' => 2,
                                        'name' => 'User 2',
                                    ],
                                    'cursor' => base64_encode('2'),
                                ],
                                dict[
                                    'node' => dict[
                                        'id' => 3,
                                        'name' => 'User 3',
                                    ],
                                    'cursor' => base64_encode('3'),
                                ],
                            ],
                            'pageInfo' => dict[
                                'hasPreviousPage' => true,
                                'startCursor' => base64_encode('2'),
                                'endCursor' => base64_encode('3'),
                            ],
                        ],
                    ],
                ],
            ),

            'test providing first without after' => tuple(
                'query {
                    human(id: 20) {
                        friends(first: 2) {
                            edges {
                                node {
                                    id
                                    name
                                }
                                cursor
                            }
                            pageInfo {
                                hasNextPage
                                startCursor
                                endCursor
                            }
                        }
                    }
                }',
                dict[],
                dict[
                    'human' => dict[
                        'friends' => dict[
                            'edges' => vec[
                                dict[
                                    'node' => dict[
                                        'id' => 0,
                                        'name' => 'User 0',
                                    ],
                                    'cursor' => base64_encode('0'),
                                ],
                                dict[
                                    'node' => dict[
                                        'id' => 1,
                                        'name' => 'User 1',
                                    ],
                                    'cursor' => base64_encode('1'),
                                ],
                            ],
                            'pageInfo' => dict[
                                'hasNextPage' => true,
                                'startCursor' => base64_encode('0'),
                                'endCursor' => base64_encode('1'),
                            ],
                        ],
                    ],
                ],
            ),

            'test retrieving the first edges in the dataset' => tuple(
                'query ($before: String!) {
                    human(id: 20) {
                        friends(before: $before, last: 2) {
                            edges {
                                node {
                                    id
                                    name
                                }
                                cursor
                            }
                            pageInfo {
                                hasPreviousPage
                                startCursor
                                endCursor
                            }
                        }
                    }
                }',
                dict['before' => base64_encode("1")],
                dict[
                    'human' => dict[
                        'friends' => dict[
                            'edges' => vec[
                                dict[
                                    'node' => dict[
                                        'id' => 0,
                                        'name' => 'User 0',
                                    ],
                                    'cursor' => base64_encode('0'),
                                ],
                            ],
                            'pageInfo' => dict[
                                'hasPreviousPage' => false,
                                'startCursor' => base64_encode('0'),
                                'endCursor' => base64_encode('0'),
                            ],
                        ],
                    ],
                ],
            ),

            'test providing last without before' => tuple(
                'query {
                    human(id: 20) {
                        friends(last: 2) {
                            edges {
                                node {
                                    id
                                    name
                                }
                                cursor
                            }
                            pageInfo {
                                hasPreviousPage
                                startCursor
                                endCursor
                            }
                        }
                    }
                }',
                dict[],
                dict[
                    'human' => dict[
                        'friends' => dict[
                            'edges' => vec[
                                dict[
                                    'node' => dict[
                                        'id' => 3,
                                        'name' => 'User 3',
                                    ],
                                    'cursor' => base64_encode('3'),
                                ],
                                dict[
                                    'node' => dict[
                                        'id' => 4,
                                        'name' => 'User 4',
                                    ],
                                    'cursor' => base64_encode('4'),
                                ],
                            ],
                            'pageInfo' => dict[
                                'hasPreviousPage' => true,
                                'startCursor' => base64_encode('3'),
                                'endCursor' => base64_encode('4'),
                            ],
                        ],
                    ],
                ],
            ),

            'test passing additional args to a connection field' => tuple(
                'query {
                    human(id: 20) {
                        named_friends(first: 1, name_prefix: "Bob") {
                            edges {
                                node {
                                    id
                                    name
                                }
                                cursor
                            }
                            pageInfo {
                                hasNextPage
                                startCursor
                                endCursor
                            }
                        }
                    }
                }',
                dict[],
                dict[
                    'human' => dict[
                        'named_friends' => dict[
                            'edges' => vec[
                                dict[
                                    'node' => dict[
                                        'id' => 0,
                                        'name' => 'Bob 0',
                                    ],
                                    'cursor' => base64_encode('0'),
                                ],
                            ],
                            'pageInfo' => dict[
                                'hasNextPage' => true,
                                'startCursor' => base64_encode('0'),
                                'endCursor' => base64_encode('0'),
                            ],
                        ],
                    ],
                ],
            ),

            'test providing both last and first' => tuple(
                'query {
                    human(id: 20) {
                        friends(last: 5, first: 5) {
                            edges {
                                node {
                                    id
                                    name
                                }
                                cursor
                            }
                            pageInfo {
                                hasPreviousPage
                                startCursor
                                endCursor
                            }
                        }
                    }
                }',
                dict[],
                shape(
                    'data' => dict[
                        'human' => dict[
                            'friends' => null,
                        ],
                    ],
                    'errors' => vec[
                        shape(
                            'message' => 'Only provide one of either "first" or "last".',
                            'path' => vec['human', 'friends'],
                        ),
                    ],
                ),
            ),
        ];
    }
}
