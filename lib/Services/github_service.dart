import 'dart:convert';
import 'dart:io';

import 'package:gitsearch/Items/search_query.dart';
import 'package:gitsearch/Items/search_result.dart';
import 'package:http/http.dart' as http;

class GitHubService{

  final String baseURL = "api.github.com";
  final String searchEndPoint = "search/repositories";

  final Map<String, String> headers = <String, String>{
    'Accept': ' application/vnd.github+json',
  };

  Future<SearchResult> repoSearch(SearchQuery queryParams) async {

    SearchResult res = SearchResult();
    
    try{

      final Uri uri = Uri.https(
        baseURL,
        searchEndPoint,
        queryParams.toApiMap()      
      );
      
      final http.Response response = await http.get(
        uri,
        headers: headers,
      );

      if( response.statusCode == 200){
        final String body = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> jsonMap = jsonDecode(body);

        res = SearchResult.fromJson(jsonMap);
      }else{
        final String body = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> jsonMap = jsonDecode(body);
        throw HttpException("${response.statusCode}:${jsonMap['message']}");
      }

    }catch(e){
        rethrow;
    }

    return res;
  }

}