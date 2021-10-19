import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomProgressLoader extends StatefulWidget {
  @override
  _CustomProgressLoaderState createState() => _CustomProgressLoaderState();
}

class _CustomProgressLoaderState extends State<CustomProgressLoader> {

  int num = 0;
  Timer t;

  @override
  void initState() {
    super.initState();
  }

  Future changeColor() async{
    for(int i = 0; i < 1000; i++){
       t = await Future.delayed(const Duration(seconds: 1), () {
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
    t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    changeColor();
    return Center(
      child:  SvgPicture.asset("assets/hearts.svg", color: num%2==0?Colors.red:num%3==0?Colors.white:Colors.redAccent,)//CircularProgressIndicator(),
    );
  }
}
