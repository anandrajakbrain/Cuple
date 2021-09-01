import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomProgressLoader extends StatefulWidget {
  @override
  _CustomProgressLoaderState createState() => _CustomProgressLoaderState();
}

class _CustomProgressLoaderState extends State<CustomProgressLoader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:  SvgPicture.asset("assets/hearts.svg")//CircularProgressIndicator(),
    );
  }
}
