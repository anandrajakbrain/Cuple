import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/ideasListResponse.dart';
import 'package:cuple_app/model/tipsListResponse.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class IdeasCardContainer extends StatefulWidget {
  IdeasData ideasData;
  IdeasCardContainer({@required this.ideasData});
  @override
  _IdeasCardContainerState createState() => _IdeasCardContainerState();
}

class _IdeasCardContainerState extends State<IdeasCardContainer> {

  String parseContent = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      parseContent = Utils(context)
          .parseHtmlString(
          widget.ideasData.content
          .toString())
          .toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print(widget.ideasData.link);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  WebViewIdea(widget.ideasData.link),
            ));
      },
      child: Container(
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
          ],
        ),
        child: GridTile(
          header: Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 8.0),
            child: widget.ideasData.image!=null?Image.network(
              "${APP_ASSET_BASE_URL+ widget.ideasData.image}",
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
            ):Image.asset(
              "assets/ideaImg2.png",
              // fit: BoxFit.cover,
              height: Utils(context).getMediaHeight() * 0.14,
              width: 1,
            ),
          ),
          child: SizedBox(),
          footer: Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              parseContent.length < 25 ? parseContent : parseContent.substring(0, 20)+".....",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Utils(context).getMediaWidth() * 0.05,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

class WebViewIdea extends StatefulWidget {
  final link;
  WebViewIdea(this.link);
  @override
  WebViewIdeaState createState() => WebViewIdeaState();
}

class WebViewIdeaState extends State<WebViewIdea> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: '${widget.link}',
      //initialUrl: "https://flutter.dev",
    );
  }
}
