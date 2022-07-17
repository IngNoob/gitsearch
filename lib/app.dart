import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gitsearch/Pages/home_page.dart';
import 'package:provider/provider.dart';

import 'package:gitsearch/Common/routes.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:gitsearch/Pages/search_page_tab.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SearchModel())
    ], 
    child:
      MaterialApp(
        title: 'GitSearch',
        theme:ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light().copyWith(primary: Colors.blueGrey)
        ),
        onGenerateRoute: (RouteSettings settings){

          if (kDebugMode) {
            print('Route: ${settings.name}');
          }

          switch(settings.name){
            case Routes.search:
              return MaterialPageRoute<dynamic>(
                  builder: (_) => const SearchPageTab(),
                  settings: settings,
                );
            default:
              return MaterialPageRoute<dynamic>(
                  builder: (_) => const HomePage(),
                  settings: settings,
                );
          }

        }        
      )
    );
  }
}
