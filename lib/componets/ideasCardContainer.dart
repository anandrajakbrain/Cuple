import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/ideasListResponse.dart';
import 'package:cuple_app/model/tipsListResponse.dart';
import 'package:cuple_app/screens/ideasDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class IdeasCardContainer extends StatefulWidget {
  IdeasData ideasData;

  IdeasCardContainer({@required this.ideasData});

  @override
  _IdeasCardContainerState createState() => _IdeasCardContainerState();
}

class _IdeasCardContainerState extends State<IdeasCardContainer> {
  bool isfev = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.ideasData.link);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => IdeasDetailsScreen(ideasData: widget.ideasData,)));
        // Utils(context).showMessage(title: "",child: Text( Utils(context).parseHtmlString(widget.ideasData.content.toString()).toString()));
      },
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.6,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color(0XFFE8F6F1),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              // blurRadius: 1
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: widget.ideasData.image != null ? Image.network(
                "${APP_ASSET_BASE_URL + widget.ideasData.image}",
                // fit: BoxFit.cover,
                fit: BoxFit.fill,
                // height: Utils(context).getMediaHeight() * 0.14,
                // width: 1,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace stackTrace) {
                  return Image.asset(
                    "assets/ideaImg2.png",
                    fit: BoxFit.fill,
                    // fit: BoxFit.cover,
                    // height: Utils(context).getMediaHeight() * 0.14,
                    // width: 1,
                  );
                },
              ) : Image.asset(
                "assets/ideaImg2.png",
                fit: BoxFit.fill,
                // fit: BoxFit.cover,
                // height: Utils(context).getMediaHeight() * 0.14,
                // width: 1,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                Utils(context).parseHtmlString(
                    widget.ideasData.content.toString()).toString(),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                style: TextStyle(
                    //color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                    icon: Icon(
                      widget.ideasData.wishlist_added != "no"
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      if (widget.ideasData.wishlist_added == "no") {
                        Plugs(context).addToWishList(
                            suggestionId: widget.ideasData.id.toString());
                      }

                      setState(() {
                        if (widget.ideasData.wishlist_added == "no") {
                          widget.ideasData.wishlist_added = "yes";
                        }
                      });
                    })),
            Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.share,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      if (widget.ideasData.link != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebViewIdea(widget.ideasData.link),
                            ));
                      } else {
                        Utils(context).showMessage(title: "Sorry",
                            child: Text("There Is No Available Link On Idea"));
                      }
                    })),
          ],
        ),
      ),
      /*child: Container(
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
            Utils(context).parseHtmlString(widget.ideasData.content.toString()).toString() ,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Utils(context).getMediaWidth() * 0.05,
                  fontWeight: FontWeight.w500),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
      ),*/
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
