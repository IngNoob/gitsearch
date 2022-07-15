import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gitsearch/Items/search_result.dart';
import 'package:gitsearch/Models/search_model.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<Widget> elements = [];
  Random rng = Random();


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
        child: Consumer<SearchModel>(
          builder: (context, sModel, child) {

           final SearchResult search = sModel.search;

            if (search.items != null) {
              elements= List.generate(search.items?.length ?? 0, (index) => ListTile(title: Text(search.items![index].fullName ?? "***Error***"), tileColor: Color.fromRGBO(rng.nextInt(255), rng.nextInt(255), rng.nextInt(255), 1) ));
            }
          
            return elements.isNotEmpty ? 
              SingleChildScrollView(child: Column( children: elements)) : 
              const Center(child: Text("Welcome, press the search button to start"));
          }
        
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<SearchModel>(context, listen: false).doSearch(),
        tooltip: 'Search',
        child: const Icon(Icons.search),
      ),
    );
  }

}
