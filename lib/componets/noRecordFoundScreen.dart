import 'package:cuple_app/configuration/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class NoRecordFoundScreen extends StatefulWidget {
  String msg;
  IconData icon;
  bool isIcon;
  NoRecordFoundScreen({this.icon=FontAwesomeIcons.thermometerEmpty,this.msg="No Record Found",this.isIcon=false});
  @override
  _NoRecordFoundScreenState createState() => _NoRecordFoundScreenState();
}

class _NoRecordFoundScreenState extends State<NoRecordFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         widget.isIcon!=true? Center(child: SvgPicture.asset("assets/hearts.svg",color: Color(0XFFD947E0),),)
          :Icon(widget.icon,size: Utils(context).getMediaWidth()*0.08,),

          SizedBox(height: 10,),
          Text(
            "${widget.msg}",
            style: TextStyle(
                color: Colors.grey,
                fontSize: Utils(context).getMediaWidth() * 0.05,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
