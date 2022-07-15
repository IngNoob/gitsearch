import 'package:gitsearch/Items/search_item.dart';

class SearchResult {
  int? totalCount;
  bool? incompleteResults;
  List<SearchItem>? items;

  SearchResult({totalCount, incompleteResults, items});

  SearchResult.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    incompleteResults = json['incomplete_results'];
    if (json['items'] != null) {
      items = <SearchItem>[];
      json['items'].forEach((v) {
        items!.add(SearchItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    data['incomplete_results'] = incompleteResults;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}