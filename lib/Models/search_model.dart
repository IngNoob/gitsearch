import 'dart:convert';

import 'package:flutter/material.dart';
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

  SearchResult _search = SearchResult();
  SearchResult get search => _search;

  Future<void> doSearch() async {

    _isBusy = true;
    notifyListeners();
    
    final Uri uri = Uri.https(
      baseURL,
      searchEndPoint,
      <String, String>{'q' : "hongkong" },
    );
    
    final http.Response response = await http.get(
      uri,
      headers: headers,
    );

    final String body = utf8.decode(response.bodyBytes);

    final Map<String, dynamic> jsonMap = jsonDecode(body);

    _search = SearchResult.fromJson(jsonMap);
    _isBusy = false;

    notifyListeners();

  }

}