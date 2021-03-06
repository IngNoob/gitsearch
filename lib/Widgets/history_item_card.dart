import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gitsearch/Items/history_item.dart';
import 'package:gitsearch/Models/history_model.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:gitsearch/Models/settings_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryItemCard extends StatelessWidget {
  const HistoryItemCard(this.item, this.tabController, {Key? key}) : super(key: key);

  final HistoryItem item;
  final TabController tabController;
  
  @override
  Widget build(BuildContext context){

    return Center(
      child: Card(
        margin: const EdgeInsets.all(4),
        child: Column( 
          mainAxisSize: MainAxisSize.min,
          children: [
            Slidable(
              key: UniqueKey(),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: deleteHistory,
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                  ),
                ],
              ),
              child: buildListTileCard(context),
            )
          ]
        ),
      )
    );
}

  Widget buildListTileCard(BuildContext context) {

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: ShapeDecoration(
          color: Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light ? 
            Theme.of(context).colorScheme.primary 
            : Theme.of(context).backgroundColor, 
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4)),
        ),
        child: Text(
          DateFormat('yyyy/MM/dd').format(DateTime.parse(item.searchDate! ) ),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: 
            Text(
              item.keyword, 
              overflow: TextOverflow.clip, 
              style: const TextStyle( fontWeight: FontWeight.bold)
            )
          ),
          IconButton(onPressed: () => doSearch(context), icon: const Icon(Icons.replay)),                  
          //IconButton(onPressed: () => deleteHistory(context), icon: const Icon(Icons.delete)),                
        ],
      ),
      onTap: () => doSearch(context)
    );

  }

  void deleteHistory(BuildContext context){
    Provider.of<HistoryModel>(context, listen: false).deleteFromHistory(item.keyword);
  }

  void doSearch(BuildContext context){
    tabController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    Provider.of<HistoryModel>(context, listen: false).addToHistory(item.keyword);
    Provider.of<SearchModel>(context, listen: false).doSearch(item.keyword);
  
  }

}