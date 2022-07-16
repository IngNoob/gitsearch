import 'package:flutter/material.dart';
import 'package:gitsearch/Items/search_query.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:provider/provider.dart';

class SearchFormWidget extends StatefulWidget {
  const SearchFormWidget({Key? key}) : super(key: key);

  @override
  State<SearchFormWidget> createState() => _SearchFormWidgetState();
}

class _SearchFormWidgetState extends State<SearchFormWidget> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SearchQuery searchData = SearchQuery();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  TextEditingController keywordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    keywordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(20),
      color:Theme.of(context).scaffoldBackgroundColor,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column( children: [
            TextFormField(
              maxLength: 20,
              controller: keywordTextController,
              decoration: const InputDecoration(
                hintText: 'Input search keyword'
              ),
              validator: (String? value){
                  if (value!.isEmpty){
                  return "Required Field";
                }
                  return null;
              },
              onSaved: (String? value){
                searchData.keyword = value;
              },    
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.search), 
              label: const Text("Search Repo"),
              onPressed: doSearch, 
            )
            
          ])
        )
      )
    );
  }

  Future<void> doSearch() async{

    FocusScope.of(context).unfocus();

    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();

      Provider.of<SearchModel>(context, listen: false).doSearch(searchData.keyword);
      
    }

  }
  

}