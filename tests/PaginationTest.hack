


use function Facebook\FBExpect\expect;
use namespace HH\Lib\C;
use namespace Slack\GraphQL;

/**
 * Test GraphQL pagination
 */
final class PaginationTest extends FixtureTest {

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
                            ],
                        ],
                    ],
                ],
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

            'test list connection first items' => tuple(
                'query {
                    alphabetConnection(first: 2) {
                        edges {
                            node
                            cursor
                        }
                        pageInfo {
                            hasNextPage
                            startCursor
                            endCursor
                        }
                    }
                }',
                dict[],
                shape(
                    'data' => dict[
                        'alphabetConnection' => dict[
                            'edges' => vec[
                                dict[
                                    'node' => 'a',
                                    'cursor' => base64_encode('0'),
                                ],
                                dict[
                                    'node' => 'b',
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
                ),
            ),

            'test list connection first items with after' => tuple(
                'query ($after: String!) {
                    alphabetConnection(after: $after, first: 2) {
                        edges {
                            node
                            cursor
                        }
                        pageInfo {
                            hasNextPage
                            startCursor
                            endCursor
                        }
                    }
                }',
                dict['after' => base64_encode('1')],
                shape(
                    'data' => dict[
                        'alphabetConnection' => dict[
                            'edges' => vec[
                                dict[
                                    'node' => 'c',
                                    'cursor' => base64_encode('2'),
                                ],
                                dict[
                                    'node' => 'd',
                                    'cursor' => base64_encode('3'),
                                ],
                            ],
                            'pageInfo' => dict[
                                'hasNextPage' => true,
                                'startCursor' => base64_encode('2'),
                                'endCursor' => base64_encode('3'),
                            ],
                        ],
                    ],
                ),
            ),

            'test list connection last items' => tuple(
                'query {
                    alphabetConnection(last: 2) {
                        edges {
                            node
                            cursor
                        }
                        pageInfo {
                            hasPreviousPage 
                            startCursor
                            endCursor
                        }
                    }
                }',
                dict[],
                shape(
                    'data' => dict[
                        'alphabetConnection' => dict[
                            'edges' => vec[
                                dict[
                                    'node' => 'y',
                                    'cursor' => base64_encode('24'),
                                ],
                                dict[
                                    'node' => 'z',
                                    'cursor' => base64_encode('25'),
                                ],
                            ],
                            'pageInfo' => dict[
                                'hasPreviousPage' => true,
                                'startCursor' => base64_encode('24'),
                                'endCursor' => base64_encode('25'),
                            ],
                        ],
                    ],
                ),
            ),

            'test list connection last items with before' => tuple(
                'query ($before: String!) {
                    alphabetConnection(before: $before, last: 2) {
                        edges {
                            node
                            cursor
                        }
                        pageInfo {
                            hasPreviousPage 
                            startCursor
                            endCursor
                        }
                    }
                }',
                dict['before' => base64_encode('24')],
                shape(
                    'data' => dict[
                        'alphabetConnection' => dict[
                            'edges' => vec[
                                dict[
                                    'node' => 'w',
                                    'cursor' => base64_encode('22'),
                                ],
                                dict[
                                    'node' => 'x',
                                    'cursor' => base64_encode('23'),
                                ],
                            ],
                            'pageInfo' => dict[
                                'hasPreviousPage' => true,
                                'startCursor' => base64_encode('22'),
                                'endCursor' => base64_encode('23'),
                            ],
                        ],
                    ],
                ),
            ),

            'namespaced connection' => tuple(
                '
                {
                    allFooObjects {
                        edges {
                            node {
                                value
                            }
                        }
                    }
                }
                ',
                dict[],
                dict[
                    'allFooObjects' => dict[
                        'edges' => vec[
                            dict[
                                'node' => dict[
                                    'value' => 'bar',
                                ],
                            ],
                        ],
                    ],
                ],
            ),

            'custom connection fields' => tuple(
                '{
                    human(id: 20) {
                        friends {
                            totalCount
                        }
                    }
                }',
                dict[],
                dict[
                    'human' => dict[
                        'friends' => dict[
                            'totalCount' => 5
                        ],
                    ],
                ],
            ),
        ];
    }
}
