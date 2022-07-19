import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gitsearch/Common/globals.dart';
import 'package:gitsearch/Items/search_query.dart';
import 'package:gitsearch/Items/search_result.dart';

import 'package:http/http.dart' as http;


class SearchModel extends ChangeNotifier{

  final String baseURL = "api.github.com";
  final String searchEndPoint = "search/repositories";

  final Map<String, String> headers = <String, String>{
    'Accept': ' application/vnd.github+json',
  };

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  final SearchQuery _queryParams = SearchQuery();
  SearchQuery get queryParams => _queryParams;

  SearchResult _searchResult = SearchResult();
  SearchResult get searchResult => _searchResult;


  Future<void> doSearch(String? keyword) async {

    _isBusy = true;
    _searchResult = SearchResult();
    notifyListeners();

    _queryParams.keyword = keyword;
    _queryParams.page = Globals.apiPageDefault;
    _searchResult = await _search();

    _isBusy = false;
    notifyListeners();

  }

  Future<void> searchNext() async {

    _isBusy = true;
    notifyListeners();

    _queryParams.page++;
    final SearchResult res = await _search();

    if(res.items != null){
      _searchResult.items?.addAll(res.items!.toList());
    }

    _isBusy = false;
    notifyListeners();

  }

  Future<SearchResult> _search() async {

    final Uri uri = Uri.https(
      baseURL,
      searchEndPoint,
      _queryParams.toApiMap()      
    );
    
    final http.Response response = await http.get(
      uri,
      headers: headers,
    );

    final String body = utf8.decode(response.bodyBytes);

    final Map<String, dynamic> jsonMap = jsonDecode(body);

    return SearchResult.fromJson(jsonMap);

  }

}