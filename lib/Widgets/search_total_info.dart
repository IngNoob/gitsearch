import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:gitsearch/Models/settings_model.dart';
import 'package:provider/provider.dart';

class SearchTotalInfo extends StatefulWidget {
  const SearchTotalInfo({Key? key}) : super(key: key);

  @override
  State<SearchTotalInfo> createState() => _SearchTotalInfoState();
}

class _SearchTotalInfoState extends State<SearchTotalInfo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(builder: (context, sModel, child) {

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            if (sModel.queryParams.keyword != null)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4)),
                ),
                child: Text(
                  sModel.queryParams.keyword!,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            const Spacer(),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                'resultCount'.tr(args: [NumberFormat.compact().format(sModel.searchResult.totalCount ?? 0)]), 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light ? 
                    Theme.of(context).colorScheme.primary 
                    : null //Default value as it is not being overriden
                )
              )
            )
          ],
        )
      );
      
    });
  }
}