import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/favouritesItemCardContainer.dart';
import 'package:cuple_app/componets/noInterNetConnectionScreen.dart';
import 'package:cuple_app/componets/noRecordFoundScreen.dart';
import 'package:cuple_app/componets/tutorialListContainer.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/tutorialsListsResponse.dart';
import 'package:cuple_app/model/userFavouritesList.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserFavoriteScreen extends StatefulWidget {
  @override
  _UserFavoriteScreenState createState() => _UserFavoriteScreenState();
}

class _UserFavoriteScreenState extends State<UserFavoriteScreen> {
  UserFavouritesList userFavouritesList;

  fetch(var id) async {
    Utils(context).checkInternet().then((value) async {
      if (value == true) {
        if (partnerData != null) {
          UserFavouritesList _userFavouritesList = await Plugs(context)
              .getUserFavouritesList(
                  partnerID:
                      partnerData != null ? partnerData.id.toString() : '');

          setState(() {
            userFavouritesList = _userFavouritesList;
          });
        }
      } else {
        Utils(context).showAlert(
            context: context,
            title: "",
            child: Container(
                height: 250, width: 150, child: NoInternetConnectionScreen()),
            handler: () {
              Navigator.pop(context);
              fetch(userDetails.id.toString());
            },
            isCancel: false);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0))
        .then((value) => fetch(userDetails.id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils(context).getMediaHeight() * 0.80,
      color: APP_BAR_COLOR,
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: userFavouritesList != null
            ? userFavouritesList.data.length > 0
                ? ListView.builder(
                    itemCount: userFavouritesList != null
                        ? userFavouritesList.data.length
                        : 0,
                    itemBuilder: (context, index) {
                      return FavouritesCardContainer(
                        isEven: index.isEven,
                        favouritesData: userFavouritesList.data[index],
                      );
                    })
                : NoRecordFoundScreen(
                    msg: "No Record Found",
                  )
            : NoRecordFoundScreen(
                icon: FontAwesomeIcons.fileDownload,
                msg: partnerData!=null?"Please Wait":"You Didn't Choose Partner Yet",
              ),
      ),
    );
  }
}
