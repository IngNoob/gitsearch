import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gitsearch/Items/search_query.dart';
import 'package:gitsearch/Models/history_model.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:gitsearch/Models/settings_model.dart';
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
  final TextEditingController _keywordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(searchData.keyword != null){
      _keywordTextController.text = searchData.keyword!;
    }
  }

  @override
  void dispose() {
    _keywordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color:Theme.of(context).scaffoldBackgroundColor,
      child: 
      GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Wrap( 
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            children: [
                SizedBox(width: 500,
                  child: TextFormField(
                    maxLength: 20,                    
                    controller: _keywordTextController,
                    decoration: InputDecoration(
                      hintText: 'inputHint'.tr(),
                      isDense: true
                    ),
                    validator: (String? value){
                        if (value!.isEmpty){
                        return 'requiredHint'.tr();
                      }
                        return null;
                    },
                    buildCounter: (
                      BuildContext context, {
                      required int currentLength, 
                      required bool isFocused, 
                      required int? maxLength
                    }) {
                      // No build counter needed
                      return null;
                    },
                    onSaved: (String? value){
                      searchData.keyword = value;
                    },    
                    
                  ) 
                ),

                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        key: const Key('searchBtn'),
                        icon: const Icon(Icons.search), 
                        label: Text('searchBtn'.tr()),
                        onPressed: doSearch, 
                      ),
                      IconButton(
                        onPressed: resetSearch, 
                        icon: Icon(
                          Icons.delete, 
                          color: Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light ? 
                            Theme.of(context).colorScheme.primary : Colors.white
                          ),
                      ),
                    ],
                  )
                )
            ]
          )
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

      await Provider.of<SearchModel>(context, listen: false).doSearch(searchData.keyword).then((bool value){
        if (value){
          Provider.of<HistoryModel>(context, listen: false).addToHistory(searchData.keyword);
        }
      });
    }

  }

  void resetSearch() async {
    setState(() {
      _keywordTextController.clear();
      _autovalidateMode = AutovalidateMode.disabled;
      Provider.of<SearchModel>(context, listen: false).resetSearch();
    });
  }
  

}