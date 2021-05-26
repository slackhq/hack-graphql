namespace Slack\GraphQL\Introspection;

final abstract class Utilities {
    const type TIntrospectionOptions = shape(
        /**
         * Whether to include descriptions in the introspection result.
         * Default: true
         */
        ?'descriptions' => bool,

        /**
         * Whether to include `specifiedByURL` in the introspection result.
         * Default: false
         */
        ?'specified_by_url' => bool,

        /**
         * Whether to include `isRepeatable` flag on directives.
         * Default: false
         */
        ?'directive_is_repeatable' => bool,

        /**
         * Whether to include `description` field on schema.
         * Default: false
         */
        ?'schema_description' => bool,

        /**
         * Whether target GraphQL server support deprecation of input values.
         * Default: false
         */
        ?'input_value_deprecation' => bool,
    );

    public static function getIntrospectionQuery(self::TIntrospectionOptions $options = shape()): string {
        $descriptions = ($options['descriptions'] ?? false) ? 'description' : '';
        $specified_by_url = ($options['specified_by_url'] ?? false) ? 'specifiedByURL' : '';
        // TODO
        $specified_by_url = '';
        $directive_is_repeatable = ($options['directive_is_repeatable'] ?? false) ? 'isRepeatable' : '';
        // TODO
        $directive_is_repeatable = '';
        $schema_description = ($options['schema_description'] ?? false) ? $descriptions : '';
        // TODO
        $schema_description = '';

        $input_deprecation = (string $value) ==> ($options['input_value_deprecation'] ?? false) ? $value : '';

        // TODO under __schema
        // subscriptionType { name }
        // directives {
        //     name
        //     {$descriptions}
        //     {$directive_is_repeatable}
        //     locations
        //     args{$input_deprecation('(includeDeprecated: true)')} {
        //         ...InputValue
        //     }
        // }
        return "
            query IntrospectionQuery {
                __schema {
                    {$schema_description}
                    queryType { name }
                    mutationType { name }
                    types {
                        ...FullType
                    }
                }
            }

            fragment FullType on __Type {
                kind
                name
                {$descriptions}
                {$specified_by_url}
                fields(includeDeprecated: true) {
                    name
                    {$descriptions}
                    args{$input_deprecation('(includeDeprecated: true)')} {
                        ...InputValue
                    }
                    type {
                        ...TypeRef
                    }
                    isDeprecated
                    deprecationReason
                }
                inputFields{$input_deprecation('(includeDeprecated: true)')} {
                    ...InputValue
                }
                interfaces {
                    ...TypeRef
                }
                enumValues(includeDeprecated: true) {
                    name
                    {$descriptions}
                    isDeprecated
                    deprecationReason
                }
                possibleTypes {
                    ...TypeRef
                }
            }

            fragment InputValue on __InputValue {
                name
                {$descriptions}
                type { ...TypeRef }
                defaultValue
                {$input_deprecation('isDeprecated')}
                {$input_deprecation('deprecationReason')}
            }

            fragment TypeRef on __Type {
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
                            ofType {
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
                }
            }
        ";
    }

}
