import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/listContainer.dart';
import 'package:cuple_app/componets/wishlistContainer.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/model/userWishListResponse.dart';
import 'package:flutter/material.dart';

class MyWishList extends StatefulWidget {
  @override
  _MyWishListState createState() => _MyWishListState();
}

class _MyWishListState extends State<MyWishList> {
  UserWishListResponse userWishListResponse;

  fetch() async {
    UserWishListResponse _userWishListResponse =
        await Plugs(context).getUserWishList();

    setState(() {
      userWishListResponse = _userWishListResponse;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) => fetch());
  }

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
        actions: [],
        elevation: 0.0,
      ),
      body: Container(
        color: APP_BAR_COLOR,
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: ListView.builder(
              itemCount: userWishListResponse != null
                  ? userWishListResponse.data.length
                  : 0,
              itemBuilder: (context, index) {
                return WishListContainer(
                  isEven: true,
                  isDelete: true,
                  userWishListData: userWishListResponse.data[index],
                  handlerCall: (){
                    fetch();
                  },
                );
              }),
        ),
      ),
    );
  }
}
