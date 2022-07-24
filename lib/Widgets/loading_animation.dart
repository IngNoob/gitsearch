import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gitsearch/Models/settings_model.dart';
import 'package:provider/provider.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> with TickerProviderStateMixin {
  
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.reverse){
        // if the animation starts going back, we refresh the widget so the image flips horizontally
        setState(() {});
      }else if (status == AnimationStatus.forward){
        // if the animation starts going back, we refresh the widget so the image flips horizontally
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    return LayoutBuilder( builder: (BuildContext context, BoxConstraints constraints) {

      Size maxSize = constraints.biggest;
      double logoSize = 70;

      Animation<RelativeRect> transition = RelativeRectTween(
        begin: RelativeRect.fromSize(
          Rect.fromLTWH(maxSize.width-(maxSize.width*0.4), maxSize.height/2+logoSize/2, logoSize, logoSize), maxSize
        ),
        end: RelativeRect.fromSize(
          Rect.fromLTWH(maxSize.width*0.4-logoSize, maxSize.height/2+logoSize/2, logoSize, logoSize), maxSize
        )
      ).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut
      ));

      return Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light?
                    Theme.of(context).colorScheme.primary : Colors.white,
                  shape: BoxShape.circle
                ),
                padding: const EdgeInsets.all(16),
                child: CircularProgressIndicator(
                  color: Provider.of<SettingsModel>(context, listen: false).theme == ThemeMode.light?
                    Colors.white : Theme.of(context).colorScheme.primary
                )
              ),
            
            Stack(
              alignment: Alignment.center,
              children: [                        
                  PositionedTransition(
                    rect: transition,
                    child:  Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY( _controller.status == AnimationStatus.reverse? pi : 0),
                      child: Image.asset("assets/images/logo.png", height: 20)
                    ),      
                  ),                  
                ],            
              )
            
          ],
        )
        
      );

    });
    
    
  }
}