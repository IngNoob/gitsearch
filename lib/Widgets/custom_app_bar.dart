import 'package:flutter/material.dart';
import 'package:gitsearch/app.dart';
import 'package:gitsearch/Widgets/drop_language_locale.dart';


class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Default flutter appbar height is 54 pixels so image height should be less than that
          Image.asset('assets/images/logo.png', height: 52),
          Stack(
            alignment: Alignment.center,
            children: [
             
              Text('GitSearch', 
                style: TextStyle(
                  fontFamily: 'Cooper-Black', 
                  fontSize: 35,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 7                  
                    ..color = Colors.white,
                ),                
              ),
              
              Text('GitSearch', 
                style: TextStyle(
                  fontFamily: 'Cooper-Black', 
                  fontSize: 35,
                  //color: Colors.red,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1.5                    
                    ..color = Colors.blueGrey,
                ),                
              ),

              const Text('GitSearch', 
                style: TextStyle(
                  fontFamily: 'Cooper-Black', 
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
            ],
          )
        ],
        
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.settings),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            // Dark mode
            PopupMenuItem(
              child: Center(
                child: Icon(
                  MyApp.themeNotifier.value == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
                  color: MyApp.themeNotifier.value == ThemeMode.light ? 
                    Theme.of(context).colorScheme.primary : null,
                )
              ),
              onTap:  () {
                MyApp.themeNotifier.value = MyApp.themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                //Navigator.pop(context);
              },
            ),
            // Language change
            const PopupMenuItem(
              child: Center(
                child: DropLanguageLocale()
              ),
            ),

          ]
        )
      ],
    );
  }

}