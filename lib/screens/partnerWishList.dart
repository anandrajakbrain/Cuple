import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/wishlistContainer.dart';
import 'package:flutter/material.dart';

class PartnerWishlist extends StatefulWidget {
  String partnerName="Jenny's";
  PartnerWishlist({this.partnerName});
  @override
  _PartnerWishlistState createState() => _PartnerWishlistState();
}

class _PartnerWishlistState extends State<PartnerWishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: Colors.white,
        title: Text(
          "${widget.partnerName} Wish List",
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
                return WishListContainer(isEven: true,isDelete: false,);
              }),
        ),
      ),
    );
  }
}
