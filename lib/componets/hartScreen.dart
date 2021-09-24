import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HartScreenComponent extends StatefulWidget {
  @override
  _HartScreenComponentState createState() => _HartScreenComponentState();
}

class _HartScreenComponentState extends State<HartScreenComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: SvgPicture.asset("assets/hearts.svg",color: Color(0XFFD947E0),),),
    );
  }
}
