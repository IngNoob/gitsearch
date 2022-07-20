import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gitsearch/Pages/home_page.dart';

import 'package:gitsearch/Common/routes.dart';
import 'package:gitsearch/Pages/search_page_tab.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Default flutter change notifier, not neccesary to use the provider package for just one value
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return  MaterialApp(
          title: 'GitSearch',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(primary: Colors.blueGrey),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.blueGrey)
          ),          
          darkTheme: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.light().copyWith(primary: const Color(0xFF424242)),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Color(0xFF424242))
          ),
          themeMode: currentMode,
          onGenerateRoute: (RouteSettings settings){

            if (kDebugMode) {
              print('Route: ${settings.name}');
            }

            switch(settings.name){
              case Routes.home:
                return MaterialPageRoute<dynamic>(
                    builder: (_) => const HomePage(),
                    settings: settings,
                  );
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
        );
      }
    );
  }
}
