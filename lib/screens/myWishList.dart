import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/listContainer.dart';
import 'package:cuple_app/componets/wishlistContainer.dart';
import 'package:flutter/material.dart';
class MyWishList extends StatefulWidget {
  @override
  _MyWishListState createState() => _MyWishListState();
}

class _MyWishListState extends State<MyWishList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: Colors.white,
        title: Text(
          "My Wish List",
          style: TextStyle(color: Colors.black),
        ),
        actions: [

        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return WishListContainer(isEven: true,isDelete: true,);
              }),
        ),
      ),
    );
  }
}
