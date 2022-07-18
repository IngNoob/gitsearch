import 'package:flutter/material.dart';
import 'package:gitsearch/Items/search_result.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:gitsearch/Widgets/search_result_item_card.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';


class HistoryPageTab extends StatefulWidget {
  const HistoryPageTab({Key? key}) : super(key: key);

  @override
  State<HistoryPageTab> createState() => _HistoryPageTabState();
}

class _HistoryPageTabState extends State<HistoryPageTab> with AutomaticKeepAliveClientMixin<HistoryPageTab>{

  List<SearchResultItemCard> elements = [];

  // PageStorageKey to avoid the listview to reset when new elements are added to the search results and the page gets rebuilt
  final PageStorageKey _listViewKey = const PageStorageKey('historyResult');
  // Scroll controller to scroll back up new search history results added
  final ScrollController _listScrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _listScrollCtrl.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    super.build(context);

    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Search Page'),
      // ),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<SearchModel>(context).isBusy,
        progressIndicator: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
        child: Column(
          children: [

            Expanded(
              child: Consumer<SearchModel>(
                builder: (context, sModel, child) {
                  final SearchResult search = sModel.searchResult;

                  if (search.items != null) {
                    // if (sModel.queryParams.page == 1 && _listScrollCtrl.positions.isNotEmpty) {
                    //   _listScrollCtrl.animateTo(_listScrollCtrl.position.minScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                    // }
                    elements= List.generate(search.items?.length ?? 0, (index) => SearchResultItemCard(search.items![index]));
                  }

                  int totalElements = 0;
                  if (sModel.searchResult.totalCount != null){
                    totalElements = sModel.searchResult.totalCount! > elements.length ? elements.length+1 : elements.length;
                  } 
                
                  return elements.isEmpty ? 
                    const Center(child: Text("Search history. Look up something to start")):
                    ListView.builder(
                      key: _listViewKey,
                      controller: _listScrollCtrl,
                      itemCount: totalElements,
                      itemBuilder: (context, index){
                        return (index == elements.length && elements.length != search.totalCount) ?
                          (!sModel.isBusy) ?
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.2, vertical: 16),
                              child: OutlinedButton(
                                child: const Text("Show more"),
                                onPressed: () => Provider.of<SearchModel>(context, listen: false).searchNext(), 
                              )
                            )
                            :
                            
                            Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.2, vertical: 16),
                                child: const Text("Searching ...")
                              )
                            )
                          :
                          elements[index];
                      }

                    );
                
                
                }
                    
              )
               
            )
              

          ],
        ),

      ),
    );
  }

}
