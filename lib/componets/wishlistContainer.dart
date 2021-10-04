import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/deleteWishListResponse.dart';
import 'package:cuple_app/model/userWishListResponse.dart';
import 'package:cuple_app/screens/createMyWishlist.dart';
import 'package:cuple_app/screens/wishListDetailsScreen.dart';
import 'package:flutter/material.dart';

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
            colors: [
              const Color(0xFFA12FCF),
              const Color(0xFFD84EF5),
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
      child: ListTile(
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
            )),
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
      ),
    );
  }
}
