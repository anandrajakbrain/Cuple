import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/noInterNetConnectionScreen.dart';
import 'package:cuple_app/componets/noRecordFoundScreen.dart';
import 'package:cuple_app/componets/wishlistContainer.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/userWishListResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PartnerWishlist extends StatefulWidget {
  String partnerName="Jenny's";
  PartnerWishlist({this.partnerName});
  @override
  _PartnerWishlistState createState() => _PartnerWishlistState();
}

class _PartnerWishlistState extends State<PartnerWishlist> {
  UserWishListResponse userWishListResponse;
  fetchPartnerWishList() async {
    Utils(context).checkInternet().then((value) async {
      if(value==true){
        if(partnerData!=null) {
          UserWishListResponse _userWishListResponse =
          await Plugs(context).getPartnerWishList(
              partnerID: partnerData.id.toString());

          setState(() {
            userWishListResponse = _userWishListResponse;
          });
        }
      }
      else {
        Utils(context).showAlert(
            context: context,
            title: "",
            child: Container(
                height: 250, width: 150, child: NoInternetConnectionScreen()),
            handler: () {
              Navigator.pop(context);
              fetchPartnerWishList();
            },
            isCancel: false);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) => fetchPartnerWishList());
  }

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
        elevation: 0,
      ),
      body: Container(
        color: APP_BAR_COLOR,
        padding: EdgeInsets.all(8.0),
        child: Center(
          child:userWishListResponse!=null?userWishListResponse.data.length>0?ListView.builder(
              itemCount: userWishListResponse.data.length,
              itemBuilder: (context, index) {
                return WishListContainer(isEven: true,isDelete: false,userWishListData: userWishListResponse.data[index],);
              }):Container(
            child: Center(child: SvgPicture.asset("assets/hearts.svg",color: Color(0XFFD947E0),),),
          ):NoRecordFoundScreen(
            icon: FontAwesomeIcons.fileDownload,
            msg: "Please Wait",
          ),
        ),
      ),
    );
  }
}
