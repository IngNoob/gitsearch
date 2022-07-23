import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gitsearch/Common/localizations/csv_asset_loader.dart';
import 'package:gitsearch/Models/history_model.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:gitsearch/app.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  /* 
    Database needs to be opened before usage so instead of doing it
    every time before a command is executed, we make sure to set it up in
    the provider before starting the main app
  */
  HistoryModel historyModel = HistoryModel();
  await historyModel.openDb();

  runApp(
    EasyLocalization(
      useOnlyLangCode: false,
      supportedLocales: const <Locale>[
        Locale('ja', 'JP'),
        Locale('en', '')
      ],
      path: 'assets/translations/translations.csv',
      assetLoader: CsvAssetLoader(),
      fallbackLocale: const Locale('ja', 'JP'), 
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => SearchModel()),
        ChangeNotifierProvider(create: (context) => historyModel)
      ], 
      child: const MyApp()
      )
    )
  );
}