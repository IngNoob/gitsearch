
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gitsearch/Common/globals.dart';
import 'package:gitsearch/Common/utils.dart';
import 'package:gitsearch/Items/search_query.dart';
import 'package:gitsearch/Items/search_result.dart';
import 'package:gitsearch/Items/search_result_item.dart';
import 'package:gitsearch/Services/github_service.dart';

class SearchModel extends ChangeNotifier{

  SearchModel({
    required this.gitService,
    required this.exceptionCatcher
  });

  final GitHubService gitService;

  // This is a callback to a function that is gonna deal with the 
  // visual feedback to the user. We can leave it as an empty funcion
  // so that there's no feedback to the user or change it for another one to
  // choose different ways of how to provide said feedback
  final OnExceptionCatch exceptionCatcher;

  final List<String> _foundRepos = [];

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  final SearchQuery _queryParams = SearchQuery();
  SearchQuery get queryParams => _queryParams;

  SearchResult _searchResult = SearchResult();
  SearchResult get searchResult => _searchResult;

  Future<bool> doSearch(String? keyword) async {

    bool res = true;

    _isBusy = true;
    _searchResult = SearchResult();
    _foundRepos.clear();
    notifyListeners();

    try{

      _queryParams.keyword = keyword;
      _queryParams.page = Globals.apiPageDefault;
      _searchResult = await gitService.repoSearch(queryParams);
      //_searchResult.items = _filterRepos(_searchResult);

    }catch(e){
      res = false;
      // In case an error pops up we clear the results and show a snackbar
      // with a message for it.
      _queryParams.reset();
      _searchResult = SearchResult();
      String msg = e.toString();
      if (e.runtimeType != HttpException){
        msg = 'errorGeneric'.tr(args: [msg]);
      }
      exceptionCatcher(msg);
    }
    _isBusy = false;
    notifyListeners();

    return res;
  }

  Future<bool> searchNext() async {

    bool res = true;

    _isBusy = true;
    notifyListeners();

    try{
      _queryParams.page++;
      final SearchResult res = await gitService.repoSearch(queryParams);

      //res.items = _filterRepos(res);

      if(res.items != null){
        _searchResult.items?.addAll(res.items!.toList());
      }else{
        // It is a rare case but sometimes github will not return more data and the query needs to be done again
        _queryParams.page--;
      }

    }catch(e){
      res = false;
      // In case an error pops up we clear the results and show a snackbar
      // with a message for it.
      _queryParams.reset();
      _searchResult = SearchResult();

      String msg = e.toString();
      if (e.runtimeType != HttpException){
        msg = 'errorGeneric'.tr(args: [msg]);
      }

      exceptionCatcher(msg);
    }

    _isBusy = false;
    notifyListeners();

    return res;
  }

  List<SearchResultItem> _filterRepos(SearchResult res) {

    // https://github.com/Giphy/GiphyAPI/issues/235
    // Sometimes elements come in duplicate, due to recent updates or because
    // there are achived versions with the same name. To avoid duplicates and unwanted errors, 
    // we filter the list。Nonetheless, due to speed (specially in large lists), we are going to skip this
    // and instead pass the hero widget the index in the list too.
    // たまに同じレポ二回以上出てくるなので、同じもの何回表示しないように、またエラーがないため（HeroWidgetとか）
    //　貰った検索結果をフィルタリングします。でも、スピードのために、とりあえずこの処理スキップします。その代わりにHeroに
    //　一覧のindexを渡します

    final List<SearchResultItem> filteredItems = [];
    if (res.items != null){
      for(SearchResultItem item in res.items!){
        if(!_foundRepos.contains(item.fullName)){
          _foundRepos.add(item.fullName!);
          filteredItems.add(item);
        }
      }
    }

    return filteredItems;
  }

}