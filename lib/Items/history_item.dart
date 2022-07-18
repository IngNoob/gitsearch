class HistoryItem {
  String keyword;
  String? searchDate;
  

  HistoryItem(this.keyword, {this.searchDate});

  HistoryItem.fromMap(Map<String, dynamic> json) :
    keyword = json['keyword'],
    searchDate = json['search_date'];    
  

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keyword'] = keyword;
    data['search_date'] = searchDate;   
    return data;
  }

  String itemParamsString(){
    return "( keyword, search_date)";
  }

  String itemValuesString(){
    return "('$keyword', '${searchDate ?? DateTime.now().toString()}')";
  }
}