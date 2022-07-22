
import 'package:flutter/material.dart';
import 'package:gitsearch/Common/globals.dart';
import 'package:gitsearch/Items/search_query.dart';
import 'package:gitsearch/Items/search_result.dart';
import 'package:gitsearch/Items/search_result_item.dart';
import 'package:gitsearch/Services/github_service.dart';

class SearchModel extends ChangeNotifier{

  SearchModel(this._gitService);

  final GitHubService _gitService; 

  final List<String> _foundRepos = [];

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  final SearchQuery _queryParams = SearchQuery();
  SearchQuery get queryParams => _queryParams;

  SearchResult _searchResult = SearchResult();
  SearchResult get searchResult => _searchResult;

  Future<void> doSearch(String? keyword) async {

    _isBusy = true;
    _searchResult = SearchResult();
    _foundRepos.clear();
    notifyListeners();

    _queryParams.keyword = keyword;
    _queryParams.page = Globals.apiPageDefault;
    _searchResult = await _gitService.repoSearch(queryParams);
    _searchResult.items = _filterRepos(_searchResult);
    
    _isBusy = false;
    notifyListeners();

  }

  Future<void> searchNext() async {

    _isBusy = true;
    notifyListeners();

    _queryParams.page++;
    final SearchResult res = await _gitService.repoSearch(queryParams);

    res.items = _filterRepos(res);

    if(res.items != null){
      _searchResult.items?.addAll(res.items!.toList());
    }

    _isBusy = false;
    notifyListeners();

  }

  List<SearchResultItem> _filterRepos(SearchResult res) {

    // https://github.com/Giphy/GiphyAPI/issues/235
    // Sometimes elements come in duplicate, due to recent updates or because
    // there are achived versions with the same name. To avoid duplicates and unwanted errors, 
    // we filter the list
    // たまに同じレポ二回以上出てくるなので、同じもの何回表示しないように、またエラーがないため（HeroWidgetとか）
    //　貰った検索結果をフィルタリングします

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