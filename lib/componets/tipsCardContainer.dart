import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/tipsListResponse.dart';
import 'package:flutter/material.dart';

class TipsCardContainer extends StatefulWidget {
  TipsData tipsData;
  TipsCardContainer({@required this.tipsData});

  @override
  _TipsCardContainerState createState() => _TipsCardContainerState();
}

class _TipsCardContainerState extends State<TipsCardContainer> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils(context).getMediaHeight() * 0.6,

      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Color(0XFFE8F6F1),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              spreadRadius: 2,
              // blurRadius: 1
            ),
          ]
      ),
      child: GridTile(
        header: Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 8.0),
          child: Image.network(
            APP_ASSET_BASE_URL+ widget.tipsData.image,
            // fit: BoxFit.cover,
            height: Utils(context).getMediaHeight() * 0.14,
            width: 1,
            errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
              return Image.asset(
                "assets/ideaImg2.png",
                // fit: BoxFit.cover,
                height: Utils(context).getMediaHeight() * 0.14,
                width: 1,
              );
            },
          ),
        ),
        child: SizedBox(),
        footer: Container(
          padding: EdgeInsets.all(8.0),
          child: Text(
            Utils(context).parseHtmlString(widget.tipsData.content.toString()).toString() ,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: Utils(context).getMediaWidth() * 0.05,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
