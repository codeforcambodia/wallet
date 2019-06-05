import 'package:graphql_flutter/graphql_flutter.dart';

class Query_syntax{
  final String query = """
    query{
      books{
        id,
        price
      }
    }
  """;
}