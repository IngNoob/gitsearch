import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gitsearch/Common/routes.dart';
import 'package:gitsearch/Pages/home_page.dart';
import 'package:gitsearch/Pages/search_page_tab.dart';
import 'package:provider/provider.dart';

import 'Models/settings_model.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<SettingsModel>(
      builder: (context, setModel, child) {

        rebuildAllChildren(context);

        return MaterialApp(
          title: 'GitSearch',
          navigatorKey: navKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(primary: Colors.blueGrey),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.blueGrey)
          ),          
          darkTheme: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.light().copyWith(primary: const Color(0xFF424242)),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Color(0xFF424242))
          ),
          themeMode: setModel.theme,
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
  
  // Not the best solution as it rebuilds the whole app, but it is the proper way to
  // make all the localizations take place.
  // https://github.com/aissat/easy_localization/issues/370
  // Though it doesn't affect our providers as the app is below them in the widget tree

    void rebuildAllChildren(BuildContext context) {
      void rebuild(Element el) {
        el.markNeedsBuild();
        el.visitChildren(rebuild);
      }
      // ignore: avoid_as
      (context as Element).visitChildren(rebuild);
    }

}
