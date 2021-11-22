import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/deleteWishListResponse.dart';
import 'package:cuple_app/model/userWishListResponse.dart';
import 'package:cuple_app/screens/createMyWishlist.dart';
import 'package:cuple_app/screens/wishListDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ideasCardContainer.dart';

class WishListContainer extends StatefulWidget {
  bool isEven;
  bool isDelete;
  UserWishListData userWishListData;
  final handlerCall;

  WishListContainer(
      {@required this.isEven,
      this.isDelete = false,
      this.userWishListData,
      this.handlerCall = null});

  @override
  _WishListContainerState createState() => _WishListContainerState();
}

class _WishListContainerState extends State<WishListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        // color: widget.isEven == true ? Color(0XFF9366ED) : Colors.white,
        gradient: new LinearGradient(
            colors: widget.isEven==true?[
              const Color(0xFFA12FCF),
              const Color(0xFFD84EF5),
            ]:[
              const Color(0xFFD84EF5),
              const Color(0xFFA12FCF),

            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),

        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 2, blurRadius: 1)
        ],
      ),
      child: Theme(
        data: ThemeData.light().copyWith(
            accentColor: Colors.white,
            primaryColor: Colors.white,
            unselectedWidgetColor: Colors.white),
        child: ExpansionTile(
          title: Text(
            Utils(context)
                .parseHtmlString(widget.userWishListData.name)
                .toString(),
            style: TextStyle(
              color: widget.isEven == true ? Colors.white70 : Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          // subtitle: Text(widget.userWishListData.updatedAt.toString()),
          children: [
            Text(
              Utils(context)
                  .parseHtmlString(widget.userWishListData.description)
                  .toString(),
              style: TextStyle(
                color: widget.isEven == true ? Colors.white70 : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            widget.isDelete==false?IconButton(
                icon: Icon(
                  FontAwesomeIcons.share,
                  size: 35,
                  color:
                  widget.isEven == true ? Colors.white : Colors.white,
                ),
                onPressed: () {
                  if (widget.userWishListData.link != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WebViewIdea(widget.userWishListData.link),
                        ));
                  } else {
                    Utils(context).showMessage(
                        title: "Sorry",
                        child: Text("There Is No Available Link On Wish List"));
                  }
                }):SizedBox(),
            widget.isDelete? Container(
              margin: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      icon: Icon(
                        FontAwesomeIcons.share,
                        size: 35,
                        color:
                            widget.isEven == true ? Colors.white : Colors.white,
                      ),
                      onPressed: () {
                        if (widget.userWishListData.link != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    WebViewIdea(widget.userWishListData.link),
                              ));
                        } else {
                          Utils(context).showMessage(
                              title: "Sorry",
                              child: Text("There Is No Available Link On Wish List"));
                        }
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 35,
                        color:
                            widget.isEven == true ? Colors.white : Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateMyWishlist(
                                      isEdit: true,
                                      userWishListData: widget.userWishListData,
                                      callback: () {
                                        widget.handlerCall();
                                      },
                                    )));
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        size: 35,
                        color:
                            widget.isEven == true ? Colors.white : Colors.white,
                      ),
                      onPressed: () {
                        Utils(context).showAlert(
                            context: context,
                            title: "Are You Sure",
                            child: Text("Do you want delete from wish list"),
                            handler: () async {
                              DeleteWishListResponse deleteWishListResponse =
                                  await Plugs(context).deleteUserWishList(
                                      id: widget.userWishListData.id
                                          .toString());
                              Navigator.pop(context);
                              widget.handlerCall();
                            },
                            isCancel: true);
                      }),
                ],
              ),
            ):SizedBox(),
          ],
        ),
      ), /*ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WisllistDetailScreen(
                        userWishListData: widget.userWishListData,
                      )));
        },
        subtitle: Text(widget.userWishListData.description,
            style: TextStyle(
              color: widget.isEven == true ? Colors.white70 : Colors.black54,
              fontWeight: FontWeight.bold,
            ),
        overflow: TextOverflow.fade,
          maxLines: 4,
        ),
        title: Text(
          Utils(context)
              .parseHtmlString(widget.userWishListData.name)
              .toString(),
          style: TextStyle(
            color: widget.isEven == true ? Colors.white70 : Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
        // subtitle: Text(
        //   "The BoxDecoration class provides a variety of ways to draw a box. The box has a border, a body, and may cast a boxShadow. The shape of the box can be a circle or a rectangle. If it is a rectangle, then the borderRadius property controls the roundness of the corners.",
        //   style: TextStyle(
        //       color: widget.isEven == true ? Colors.white : Colors.black,
        //       fontSize: 17),
        // ),
        trailing: widget.isDelete == true
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 35,
                        color:
                            widget.isEven == true ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateMyWishlist(isEdit: true,userWishListData: widget.userWishListData,callback: (){
                         widget.handlerCall();
                       },)));
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        size: 35,
                        color:
                            widget.isEven == true ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        Utils(context).showAlert(
                            context: context,
                            title: "Are You Sure",
                            child: Text("Do you want delete from wish list"),
                            handler: () async {
                              DeleteWishListResponse deleteWishListResponse =
                                  await Plugs(context).deleteUserWishList(
                                      id: widget.userWishListData.id
                                          .toString());
                              Navigator.pop(context);
                              widget.handlerCall();
                            },
                            isCancel: true);
                      }),
                ],
              )
            : SizedBox(),
      ),*/
    );
  }
}
