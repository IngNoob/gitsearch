import 'package:gitsearch/Common/globals.dart';

class SearchQuery {

  String? keyword;
  int sort = 1;
  int order = 1;
  int perPage = Globals.apiPerPageDefault;
  int page = Globals.apiPageDefault;

  SearchQuery({keyword, sort, order, perPage, page});

  SearchQuery.fromJson(Map<String, dynamic> json) {
    keyword = json['q'];
    sort = json['sort'];
    order = json['order'];
    perPage = json['per_page'];
    page = json['page'];
  }
  
   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'keyword' : keyword,
      //'sort': order,
      //'order': sort,
      'per_page': perPage,
      'page': page,    
    };
  }

   Map<String, dynamic> toApiMap() {
    return <String, dynamic>{
      'q' : keyword,
      //'sort': order,
      //'order': sort,
      'per_page': perPage.toString(),
      'page': page.toString(),
    };
  }

}
