import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/ideasCardContainer.dart';
import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/ideasListResponse.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IdeasDetailsScreen extends StatefulWidget {
  IdeasData ideasData;

  IdeasDetailsScreen({@required this.ideasData});

  @override
  _IdeasDetailsScreenState createState() => _IdeasDetailsScreenState();
}

class _IdeasDetailsScreenState extends State<IdeasDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_BAR_COLOR,
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: APP_BAR_COLOR,
        elevation: 0,
        title: Text(
          widget.ideasData.name ?? "Date Ideas",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
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
              }),
          IconButton(
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
                  Utils(context).showMessage(
                      title: "Sorry",
                      child: Text("There Is No Available Link On Idea"));
                }
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: Utils(context).getMediaHeight() * 0.30,
                  width: Utils(context).getMediaWidth() * 0.55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        color: Colors.grey[350],
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Image.network(
                    APP_ASSET_BASE_URL + widget.ideasData.image,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: Utils(context).getMediaHeight() * 0.01,
                ),
                Text(
                  widget.ideasData.name,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Utils(context).getMediaWidth() * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  Utils(context)
                      .parseHtmlString(widget.ideasData.content.toString())
                      .toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Utils(context).getMediaWidth() * 0.05,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
