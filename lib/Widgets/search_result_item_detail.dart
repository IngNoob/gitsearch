import 'package:flutter/material.dart';
import 'package:gitsearch/Items/search_result_item.dart';
import 'package:intl/intl.dart';


class SearchResultItemDetail extends StatefulWidget {
  const SearchResultItemDetail(this.item, {Key? key}) : super(key: key);

  final SearchResultItem item;

  @override
  State<SearchResultItemDetail> createState() => _SearchResultItemDetailState();
}

class _SearchResultItemDetailState extends State<SearchResultItemDetail> {



  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        insetPadding: const EdgeInsets.all(16),
        contentPadding: const EdgeInsets.all(16),
        title: Text(widget.item.name ?? "***Error***"),
        content:  Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(children: [
              

              /*
                リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数
              */

              Flexible(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: ShapeDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Column(
                    children: [
                      Hero(
                        tag: widget.item.name as String,
                        child: Container(
                          child: widget.item.owner!.avatarUrl != null ?
                            Image.network(widget.item.owner!.avatarUrl as String) : 
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              child: const Icon(Icons.person, size: 80, color: Colors.white)
                            ),
                            
                        )
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          widget.item.owner?.login ?? "",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, overflow: TextOverflow.clip),
                        )
                      )
                    ]
                ),
                )
              ),

              const SizedBox(width: 8),

              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    // Full name and language
                    Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(widget.item.fullName ?? "***Error***", overflow: TextOverflow.clip,)
                        ),
                        Container(padding: const EdgeInsets.all(4),
                          decoration: ShapeDecoration(
                            color: Colors.red,
                            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4)),
                          ),
                          child: Center(child: 
                            Text(
                              widget.item.language ?? "NONE", 
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            )
                          )
                        )
                      ],
                    ),

                    const SizedBox(height: 16),
                    
                    // Stars and watching
                    Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.star_border, color: Theme.of(context).colorScheme.primary ),
                              Flexible(
                                child: Text(widget.item.stargazersCount! > 0 ? 
                                  "${NumberFormat.compact().format(widget.item.stargazersCount)}\nstars" : "***Error***", 
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                )
                              )
                            ],
                          )
                        ),
                        Flexible(
                          child: Row( 
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.remove_red_eye_outlined, color: Theme.of(context).colorScheme.primary ),
                              Flexible(
                                child: Text(widget.item.watchersCount! > 0 ? 
                                  "${NumberFormat.compact().format(widget.item.watchersCount)}\nwatching" : "***Error***", 
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                )
                              )
                            ],
                          )
                        ),
                        
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Forks and issues
                    Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.fork_right_outlined, color: Theme.of(context).colorScheme.primary ),
                              Flexible(
                                child: Text(widget.item.forksCount! > 0 ? 
                                  "${NumberFormat.compact().format(widget.item.forksCount)}\nforks" : "***Error***", 
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                )
                              )
                            ],
                          )
                        ),
                        Flexible(
                          child: Row( 
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.adjust_outlined, color: Theme.of(context).colorScheme.primary ),
                              Flexible(
                                child: Text(widget.item.openIssuesCount! > 0 ? 
                                  "${NumberFormat.compact().format(widget.item.openIssuesCount)}\nissues" : "***Error***", 
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                )
                              )
                            ],
                          )
                        ),
                        
                      ],
                    ),
                                  
                  ],
                )
              )
            ],
          ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.close), 
              label: const Text("Close"),
              onPressed: ()=> Navigator.of(context).pop() 
            )
          ],
        )
      )
    );
  }

}