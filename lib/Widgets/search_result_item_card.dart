import 'package:flutter/material.dart';
import 'package:gitsearch/Items/search_result_item.dart';
import 'package:gitsearch/Widgets/search_result_item_detail.dart';

class SearchResultItemCard extends StatefulWidget {
  const SearchResultItemCard(this.item, {Key? key}) : super(key: key);

  final SearchResultItem item;

  @override
  State<SearchResultItemCard> createState() => _SearchResultItemCardState();
}

class _SearchResultItemCardState extends State<SearchResultItemCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Column( 
          mainAxisSize: MainAxisSize.min,
          children: [
              ListTile(
                leading: Hero(
                  tag: widget.item.name as String,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      backgroundImage: widget.item.owner!.avatarUrl != null ? NetworkImage(widget.item.owner!.avatarUrl as String): null,
                      child: widget.item.owner!.avatarUrl == null ? const Icon(Icons.person, color: Colors.white) : null
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
                      Text(widget.item.name ?? "***Error***", overflow: TextOverflow.clip,)
                    ),                    
                  ],
                ),
                trailing: const Icon(Icons.add),
                onTap: showDetail,
              )
            ]
        ),
      )
    );
  }

  void showDetail(){

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false, // set to false
        barrierDismissible: true,
        barrierColor: Colors.grey.withOpacity(0.3),
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        pageBuilder: (_, __, ___) => SearchResultItemDetail(widget.item),
      ),
    );
  }

}