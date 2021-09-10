import 'package:cuple_app/model/userFavouritesList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FavouritesCardContainer extends StatefulWidget {
 FavouritesData favouritesData;
 bool isEven;
 FavouritesCardContainer({this.favouritesData,this.isEven});
  @override
  _FavouritesCardContainerState createState() => _FavouritesCardContainerState();
}

class _FavouritesCardContainerState extends State<FavouritesCardContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: widget.isEven == true ? Color(0XFF9366ED) : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 2, blurRadius: 1)
        ],
      ),
      child: ListTile(
        title: Text(widget.favouritesData.reminderDate == null ? "24-08-2021 18:52" :
        DateFormat.yMMMEd().format(DateTime.parse(widget.favouritesData.reminderDate)),
          style: TextStyle(
              color: widget.isEven == true ? Colors.white70 : Colors.black54,
              fontSize: 14),
        ),
        subtitle: Text(
          "${widget.favouritesData.remindername}",
          style: TextStyle(
              color: widget.isEven == true ? Colors.white : Colors.black,
              fontSize: 17),
        ),
        // trailing: IconButton(
        //     icon: Icon(
        //       Icons.delete_outline,
        //       size: 35,
        //       color: widget.isEven == true ? Colors.white : Colors.black,
        //     ),
        //     onPressed: () {
        //       // fetch(widget.tutorialData.id);
        //     }),
      ),
    );
  }
}
