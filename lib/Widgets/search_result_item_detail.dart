import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gitsearch/Items/search_result_item.dart';
import 'package:gitsearch/app.dart';


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
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Stack(
          alignment: Alignment.topRight,
          children: [

            IconButton(
              icon: Icon(Icons.close, 
                color: MyApp.themeNotifier.value == ThemeMode.light ? 
                  Theme.of(context).colorScheme.primary 
                  : Theme.of(context).backgroundColor
              ),
              onPressed: ()=> Navigator.of(context).pop()
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column( mainAxisSize: MainAxisSize.min,
                children: [
                  
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric( vertical: 8),
                    child: Text(
                      widget.item.name ?? "***Error***", 
                      style: Theme.of(context).textTheme.titleLarge)
                  ),
                  
                  Column(
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
                              color: MyApp.themeNotifier.value == ThemeMode.light ? 
                                Theme.of(context).colorScheme.primary 
                                : Theme.of(context).backgroundColor,
                              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4)),
                            ),
                            child: Column(
                              children: [
                                Hero(
                                  tag: widget.item.fullName as String,
                                  child: Container(
                                    child: widget.item.owner!.avatarUrl != null ?
                                      Image.network(widget.item.owner!.avatarUrl as String) : 
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundColor: MyApp.themeNotifier.value == ThemeMode.light ? 
                                          Theme.of(context).colorScheme.primary 
                                          : Theme.of(context).backgroundColor,
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
                                          child: Text(widget.item.stargazersCount != null ? 
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
                                          child: Text(widget.item.watchersCount != null ? 
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
                                          child: Text(widget.item.forksCount != null ?  
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
                                          child: Text(widget.item.openIssuesCount != null ? 
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
                      
                      ]),
                      const SizedBox(height: 16),
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.archive), 
                            label: const Text("Browse Repo"),
                            style: ElevatedButton.styleFrom(
                              primary: MyApp.themeNotifier.value == ThemeMode.light ? 
                                Theme.of(context).colorScheme.primary 
                                : Theme.of(context).backgroundColor
                            ),
                            onPressed: () => openBrowser(widget.item.htmlUrl ?? ''),  
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.person), 
                            label: const Text("Browse user"),
                            style: ElevatedButton.styleFrom(
                              primary: MyApp.themeNotifier.value == ThemeMode.light ? 
                                Theme.of(context).colorScheme.primary 
                                : Theme.of(context).backgroundColor
                            ),
                            onPressed: () => openBrowser(widget.item.owner?.htmlUrl  ?? ''), 
                          ),
                        ],
                      )
                      
                    ],
                  )
                ],
              )
            )
          
          ],
        )

      )
    );
  }


 Future<void> openBrowser(String url) async {
  
  final Uri uri = Uri.parse(url);

  if (!await launchUrl(uri)) {
    throw 'Could not launch $url';
  }

 }

}