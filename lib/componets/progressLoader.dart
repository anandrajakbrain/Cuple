import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomProgressLoader extends StatefulWidget {
  @override
  _CustomProgressLoaderState createState() => _CustomProgressLoaderState();
}

class _CustomProgressLoaderState extends State<CustomProgressLoader> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorAnimation;
  Animation<double> _sizeAnimation;
  int num = 0;
  Timer t;

  @override
  void initState() {
    super.initState();
    // changeColor();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _colorAnimation = ColorTween(begin: Colors.white, end: Colors.red)
        .animate(_animationController);
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 40, end: 80), weight: 80),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 80, end: 40), weight: 80),
    ]).animate(_animationController);

    _animationController.repeat(reverse: true);
    _animationController.addListener(() {
      // print(_colorAnimation.value);
    });

  }

  Future changeColor() async{
    for(int i = 0; i < 1000; i++){
       t = await Future.delayed(const Duration(milliseconds: 200), () {
         if(mounted){
           setState(() {
             num++;
           });
         }
        return;
      });
    }
  }

  @override
  void dispose() {
    // t?.cancel();
    _animationController.dispose();
    super.dispose();
    // _animationController.stop();

  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child:  AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, _) {
          return SvgPicture.asset(
            "assets/hearts.svg",
            color: _colorAnimation.value,
            height: _sizeAnimation.value,
            width: _sizeAnimation.value,
          );
        },
      ) ,//CircularProgressIndicator(),
    );
  }
}
