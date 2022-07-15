import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gitsearch/Common/routes.dart';
import 'package:gitsearch/Models/search_model.dart';
import 'package:gitsearch/Pages/search_page.dart';

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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (RouteSettings settings){

          if (kDebugMode) {
            print('Route: ${settings.name}');
          }

          switch(settings.name){
            case Routes.search:
              return MaterialPageRoute<dynamic>(
                  builder: (_) => const SearchPage(),
                  settings: settings,
                );
            default:
              return MaterialPageRoute<dynamic>(
                  builder: (_) => const SearchPage(),
                  settings: settings,
                );
          }

        }        
      )
    );
  }
}
