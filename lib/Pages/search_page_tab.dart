import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gitsearch/Items/search_result.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:gitsearch/Models/settings_model.dart';
import 'package:gitsearch/Widgets/search_form_widget.dart';
import 'package:gitsearch/Widgets/search_result_item_card.dart';
import 'package:gitsearch/Widgets/search_total_info.dart';

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

            Flexible(
              child: Consumer<SearchModel>(
                builder: (context, sModel, child) {
                  final SearchResult search = sModel.searchResult;

                  elements = List.generate(search.items?.length ?? 0, (index) => SearchResultItemCard(search.items![index], index));

                  bool moreFlag = false;
                  if (sModel.searchResult.totalCount != null){
                    moreFlag = sModel.searchResult.totalCount! > elements.length;
                  } 

                  final Color outlineColor = 
                    Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light ? 
                    Theme.of(context).colorScheme.primary : Colors.white;
                
                  return Column(
                    children: [
                      // Searched keyword, total results
                      const SearchTotalInfo(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8), 
                        child: Divider(color: Theme.of(context).colorScheme.primary, thickness: 3,)
                      ),

                      elements.isEmpty ? 
                      Expanded(child:
                        Center(child: Text('welcomeSearch'.tr(), textAlign: TextAlign.center))
                      ) 
                      :
                      Expanded( 
                        child: ListView(
                          children: [
                            // Can't use orientation builder here cause it gives the orientation of the
                            // parent widget, which in listview's case is alway vertical
                            // https://stackoverflow.com/questions/50757851/orientation-builder-gives-wrong-orientation
                            AlignedGridView.count(
                              key: _listViewKey,
                              controller: _listScrollCtrl,
                              crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 1 : 3,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),             
                              itemCount: elements.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return elements[index];
                                }
                              ),
                                
                            
                            if (!sModel.isBusy && moreFlag)                                                                     
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.2, vertical: 16),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary:  outlineColor,
                                    side: BorderSide(color: outlineColor)
                                  ),
                                  child: Text('more'.tr()),
                                  onPressed: () => Provider.of<SearchModel>(context, listen: false).searchNext(), 
                                )
                              ),
                              
                            if (sModel.isBusy)
                              Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.2, vertical: 16),
                                  child: Text('searching'.tr())
                                )
                              )
                            
                          ],
                        )
                      ),

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

}
