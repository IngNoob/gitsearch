import 'package:flutter/material.dart';
import 'package:gitsearch/Models/settings_model.dart';
import 'package:gitsearch/Widgets/drop_language_locale.dart';
import 'package:provider/provider.dart';


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
                  Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
                  color: Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light ? 
                    Theme.of(context).colorScheme.primary : null,
                )
              ),
              onTap:  () {
                Provider.of<SettingsModel>(context, listen: false).toogleThemeMode();
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