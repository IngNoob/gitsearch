import 'package:flutter/material.dart';
import 'package:gitsearch/Items/search_result.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:gitsearch/Widgets/search_form_widget.dart';
import 'package:gitsearch/Widgets/search_result_item_card.dart';
import 'package:gitsearch/app.dart';
import 'package:intl/intl.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';


class SearchPageTab extends StatefulWidget {
  const SearchPageTab({Key? key}) : super(key: key);

  @override
  State<SearchPageTab> createState() => _SearchPageTabState();
}

class _SearchPageTabState extends State<SearchPageTab> with AutomaticKeepAliveClientMixin<SearchPageTab> {

  List<SearchResultItemCard> elements = [];

  // Key to avoid rebuilds produced by ModalProgressHUD widget
  final GlobalKey<State> _formWidgetKey = GlobalKey<State>();

  // PageStorageKey to avoid the listview to reset when new elements are added to the search results and the page gets rebuilt
  final PageStorageKey _listViewKey = const PageStorageKey('searchResult');
  // Scroll controller to scroll back up on new search
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
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<SearchModel>(context).isBusy,
        progressIndicator: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
        child: Column(
          children: [

            SearchFormWidget(key: _formWidgetKey),

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
                    totalElements = sModel.searchResult.totalCount! > elements.length ? elements.length + 1 : elements.length;
                  } 
                
                  return elements.isEmpty ? 
                    const Center(child: Text("Welcome, press the search button to start")):
                    Column(
                      children: [
                        // Searched keyword, total results
                        buildTotalParams(sModel),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8), 
                          child: Divider(color: Theme.of(context).colorScheme.primary, thickness: 2,)
                        ),
                        Expanded(
                          child: ListView.builder(
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
                          )
                        )
                      ],
                    );
                                
                }
                    
              )
               
            )
              
          ],
        ),

      ),
    );
  }

  Widget buildTotalParams(SearchModel sModel){
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4)),
            ),
            child: Text(
              sModel.queryParams.keyword ?? '-',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              "${NumberFormat.compact().format(sModel.searchResult.totalCount ?? 0)} repositories", 
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: MyApp.themeNotifier.value == ThemeMode.light ? 
                  Theme.of(context).colorScheme.primary 
                  : null //Default value as it is not being overriden
              )
            )
          )
        ],
      )
    );
  }

}
