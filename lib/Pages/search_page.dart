import 'package:flutter/material.dart';
import 'package:gitsearch/Items/search_result.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:gitsearch/Widgets/search_form_widget.dart';
import 'package:gitsearch/Widgets/search_result_item_card.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<SearchResultItemCard> elements = [];

  // Key to avoid rebuilds produced by ModalProgressHUD widget
  GlobalKey<State> formWidgetKey = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<SearchModel>(context,).isBusy,
        progressIndicator: CircularProgressIndicator(color: Theme.of(context).primaryColor),
        child: Column(
          children: [

            SearchFormWidget(key: formWidgetKey,),

            Expanded(
              child: Consumer<SearchModel>(
                builder: (context, sModel, child) {
                  final SearchResult search = sModel.search;
                    if (search.items != null) {
                    elements= List.generate(search.items?.length ?? 0, (index) => SearchResultItemCard(search.items![index]));
                  }
                
                  return elements.isNotEmpty ? 
                    SingleChildScrollView(child: Column( children: elements)) : 
                    const Center(child: Text("Welcome, press the search button to start"));
                }
              
              )
            )
          ],
        ),

      ),
    );
  }

}
