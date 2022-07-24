import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gitsearch/Items/search_result_item.dart';
import 'package:gitsearch/Models/settings_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class SearchResultItemDetail extends StatefulWidget {
  const SearchResultItemDetail(this.item, this.index, {Key? key}) : super(key: key);

  final SearchResultItem item;
  final int index;

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
              icon: Icon(Icons.close, size: 30,
                color: Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light ? 
                  Theme.of(context).colorScheme.primary 
                  : Theme.of(context).backgroundColor
              ),
              onPressed: ()=> Navigator.of(context).pop()
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column( 
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  Container(
                    padding: const EdgeInsets.symmetric( vertical: 8),
                    child: Text(
                      widget.item.name ?? "***Error***", 
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.start
                    )
                  ),
                  
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      Row(mainAxisSize: MainAxisSize.min, children: [
                        /*
                          リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数
                        */
                        // User pic and name
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: ShapeDecoration(
                              color: Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light ? 
                                Theme.of(context).colorScheme.primary 
                                : Theme.of(context).backgroundColor,
                              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4)),
                            ),
                            child: Column(
                              children: [
                                // User profile pic/avatar
                                Hero(
                                  tag: widget.item.fullName! + widget.index.toString(),
                                  child: Container(
                                    child: widget.item.owner!.avatarUrl != null ?
                                      Image.network(widget.item.owner!.avatarUrl as String, height: 100) : 
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light ? 
                                          Theme.of(context).colorScheme.primary 
                                          : Theme.of(context).backgroundColor,
                                        child: const Icon(Icons.person, size: 80, color: Colors.white)
                                      ),
                                      
                                  )
                                ),
                                // User name
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
                        
                        // Repo details
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Full name(repo) and language
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
                              Row( mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(Icons.star_border, color: Theme.of(context).colorScheme.primary ),
                                        Flexible(
                                          child: Text(widget.item.stargazersCount != null ? 
                                            'stars'.tr(args: [NumberFormat.compact().format(widget.item.stargazersCount)]) : "***Error***", 
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
                                            'watching'.tr(args: [NumberFormat.compact().format(widget.item.watchersCount)]) : "***Error***", 
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
                                            'forks'.tr(args: [NumberFormat.compact().format(widget.item.forksCount)]) : "***Error***", 
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
                                            'issues'.tr(args: [NumberFormat.compact().format(widget.item.openIssuesCount)]) : "***Error***", 
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

                      Row(mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric( horizontal: 8),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.archive), 
                              label: Text('repoCheck'.tr()),
                              style: ElevatedButton.styleFrom(
                                primary: Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light ? 
                                  Theme.of(context).colorScheme.primary 
                                  : Theme.of(context).backgroundColor
                              ),
                              onPressed: () => openBrowser(widget.item.htmlUrl ?? ''),  
                            )
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric( horizontal: 8),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.person), 
                              label: Text('profileCheck'.tr()),
                              style: ElevatedButton.styleFrom(
                                primary: Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light ? 
                                  Theme.of(context).colorScheme.primary 
                                  : Theme.of(context).backgroundColor
                              ),
                              onPressed: () => openBrowser(widget.item.owner?.htmlUrl  ?? ''), 
                            )
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