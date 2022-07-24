import 'package:flutter/material.dart';
import 'package:gitsearch/Items/search_result_item.dart';
import 'package:gitsearch/Widgets/search_result_item_detail.dart';

class SearchResultItemCard extends StatelessWidget {
  const SearchResultItemCard(this.item, this.index, {Key? key}) : super(key: key);

  final SearchResultItem item;
  final int index;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Card(
        margin: const EdgeInsets.all(8),
        child: 
          ListTile(
            leading: Hero(
              tag: item.fullName!+index.toString(),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  backgroundImage: item.owner!.avatarUrl != null ? NetworkImage(item.owner!.avatarUrl as String): null,
                  child: item.owner!.avatarUrl == null ? const Icon(Icons.person, color: Colors.white) : null
                ),
              )
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child:  Icon(Icons.book)
                ),
                Expanded(child:
                  Text(item.name ?? "***Error***", overflow: TextOverflow.ellipsis)
                ),
              ],
            ),
            trailing: const Icon(Icons.add),
            onTap: () => showDetail(context),
          )
      )
    );
  }

  void showDetail(BuildContext context){

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false, // set to false
        barrierDismissible: true,
        barrierColor: Colors.grey.withOpacity(0.3),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        pageBuilder: (_, __, ___) => SearchResultItemDetail(item, index),
      ),
    );
  }

}