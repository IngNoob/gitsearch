import 'package:flutter/material.dart';
import 'package:gitsearch/app.dart';

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
        IconButton(
          icon: Icon(
            MyApp.themeNotifier.value == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
            color: Colors.white,
          ),
          onPressed: () {
            MyApp.themeNotifier.value = MyApp.themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
          }
        )
      ],
    );
  }
}