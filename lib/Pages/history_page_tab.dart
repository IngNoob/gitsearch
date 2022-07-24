import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gitsearch/Items/history_item.dart';
import 'package:gitsearch/Models/history_model.dart';
import 'package:gitsearch/Widgets/history_item_card.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';


class HistoryPageTab extends StatefulWidget {
  const HistoryPageTab(this.tabController, {Key? key}) : super(key: key);

  final TabController tabController;


  @override
  State<HistoryPageTab> createState() => _HistoryPageTabState();
}

class _HistoryPageTabState extends State<HistoryPageTab> with AutomaticKeepAliveClientMixin<HistoryPageTab>{

  List<HistoryItemCard> elements = [];

  // PageStorageKey to avoid the listview to reset when new elements are added to the search results and the page gets rebuilt
  final PageStorageKey _listViewKey = const PageStorageKey('historyResult');
  // Scroll controller to scroll back up new search history results added
  final ScrollController _listScrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    // It is called once the first drawing is done to avoid unnecesary rebuilds
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<HistoryModel>(context, listen: false).getHistory();
    });
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

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<HistoryModel>(context).isBusy,
        progressIndicator: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
        child: Column(
          children: [

            Expanded(
              child: Consumer<HistoryModel>(
                builder: (context, hModel, child) {
                  final List<HistoryItem> history = hModel.history;

                  elements= List.generate(history.length, (index) => HistoryItemCard(history[index], widget.tabController) );

                  int totalElements = 0;
                  totalElements = hModel.history.length > elements.length ? elements.length+1 : elements.length;
                
                  return elements.isEmpty ? 
                    Center(child: Text('welcomeHistory'.tr(), textAlign: TextAlign.center)):
                    ListView.builder(
                      key: _listViewKey,
                      controller: _listScrollCtrl,
                      itemCount: totalElements,
                      itemBuilder: (context, index){
                        return elements[index];
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
