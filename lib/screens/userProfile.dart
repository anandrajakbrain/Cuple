import 'package:cuple_app/componets/backButton.dart';
import 'package:cuple_app/componets/customMenuButton.dart';
import 'package:cuple_app/configuration/APIs.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/model/listUserReminderResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'edit_profile.dart';
//
// class UserProfileScreen extends StatefulWidget {
//   @override
//   _UserProfileScreenState createState() => _UserProfileScreenState();
// }
//
// class _UserProfileScreenState extends State<UserProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: APP_BAR_COLOR,
//         leading: CustomMenuButton(),
//         title: Text(
//           "User Profile",
//           style: TextStyle(color: Colors.black),
//         ),
//         elevation: 0,
//       ),
//       body: Container(
//         color: APP_BAR_COLOR,
//         child: Center(
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8.0),
//                 child: Stack(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(top: 48),
//                       height: 300,
//                       width: Utils(context).getMediaWidth() * 0.95,
//                       decoration: BoxDecoration(
//                         color: Colors.grey,
//                         gradient: LinearGradient(colors: [
//                           Color(0XFFE154E9),
//                           Color(0XFF610AB4),
//                         ]),
//                         borderRadius: BorderRadius.circular(16.0),
//                       ),
//                       child: Container(
//                         child: Center(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 height: Utils(context).getMediaHeight() * 0.03,
//                               ),
//                               Text(
//                                 "John Doe",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize:
//                                       Utils(context).getMediaWidth() * 0.05,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 "JohnDoe@gmail.com",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize:
//                                       Utils(context).getMediaWidth() * 0.04,
//                                   // fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Divider(
//                                 color: Colors.white70,
//                                 indent: 20,
//                                 endIndent: 20,
//                                 // indent: Utils(context).getMediaWidth()*0.60,
//                                 // endIndent: Utils(context).getMediaWidth()*0.60,
//                               ),
//                               Container(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Table(
//                                   children: [
//                                     getlabel(
//                                         labelName: "Mobile No",
//                                         value: "033 2265 1318"),
//                                     getlabel(
//                                         labelName: "Gender", value: "Male"),
//                                     getlabel(
//                                         labelName: "Birth Date",
//                                         value: "13 Jun, 1990"),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: SizedBox(
//                         child: CircleAvatar(
//                           radius: 60.0,
//                           backgroundColor: Colors.white,
//                           child: CircleAvatar(
//                             /*child: Align(
//                               alignment: Alignment.bottomRight,
//                               child: CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 radius: 12.0,
//                                 child: Icon(
//                                   Icons.camera_alt,
//                                   size: 15.0,
//                                   color: Color(0XFF404040),
//                                 ),
//                               ),
//                             ),*/
//                             radius: 50.0,
//                             backgroundImage:
//                                 AssetImage("assets/profile_user.jpg"),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // SizedBox(
//               //   height: Utils(context).getMediaHeight()*0.06,
//               // ),
//               ...getCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   TableRow getlabel({@required String labelName, @required value}) {
//     return TableRow(children: [
//       Center(
//         child: Container(
//           margin: EdgeInsets.only(top: 5.0, bottom: 8.0),
//           child: Text(
//             "$labelName",
//             style: TextStyle(
//                 color: APP_BAR_COLOR,
//                 fontSize: Utils(context).getMediaWidth() * 0.045),
//           ),
//         ),
//       ),
//       Center(
//         child: Container(
//           margin: EdgeInsets.only(top: 5.0, bottom: 8.0),
//           child: Text(
//             ":",
//             style: TextStyle(
//                 color: APP_BAR_COLOR,
//                 fontSize: Utils(context).getMediaWidth() * 0.045),
//           ),
//         ),
//       ),
//       Center(
//         child: Container(
//           margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
//           child: Text(
//             "$value",
//             style: TextStyle(
//                 color: APP_BAR_COLOR,
//                 fontSize: Utils(context).getMediaWidth() * 0.045,
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     ]);
//   }
//
//   getCard() {
//     return [
//       Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               "Anniversary",
//               style: TextStyle(
//                 fontSize: Utils(context).getMediaWidth() * 0.05,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           )),
//       Container(
//         width: Utils(context).getMediaWidth() * 0.95,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(colors: [
//             Color(0XFFE154E9),
//             Color(0XFF610AB4),
//           ]),
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         child: Container(
//           child: Table(
//             children: [
//               getlabel(labelName: "Marriage Anniversary", value: "19 Aug, 2018"),
//               getlabel(labelName: "Marriage Anniversary", value: "19 Aug, 2018"),
//             ],
//           ),
//         ),
//       ),
//     ];
//   }
// }
class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ListUserReminderResponse listUserReminderResponse;
  fetch() async {
    ListUserReminderResponse _listUserReminderResponse = await Plugs(context)
        .listUserReminderList(userId: userDetails.id.toString());

    setState(() {
      listUserReminderResponse = _listUserReminderResponse;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        backgroundColor: APP_BAR_COLOR,
        title: Text(
          "My Profile",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        color: APP_BAR_COLOR,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Utils(context).getMediaWidth() * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.08),
                    child: Card(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.height * 0.03),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0XFFE556EB), Color(0XFF5E08B3)])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    top:
                                    MediaQuery.of(context).size.height * 0.1)),
                            Text(
                              "${userDetails.name}",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top:
                                    MediaQuery.of(context).size.height * 0.01)),
                            Text(
                              "${userDetails.email}",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w300),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top:
                                    MediaQuery.of(context).size.height * 0.02)),
                            Divider(
                              thickness: 0.2,
                              color: Colors.white,
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top:
                                    MediaQuery.of(context).size.height * 0.02)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                  MediaQuery.of(context).size.height * 0.08),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mobile No.",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                      Text(
                                        "Gender",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                      Text(
                                        "Birth Date",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ":\t\t${userDetails.phone}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                      Text(
                                        ":\t\tMale",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                      Text(
                                        ":\t\t${userDetails.dob!=null?DateFormat("d MMM, y").format(DateTime.parse(userDetails.dob)):''}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02)),
                  Container(
                    child: Text(
                      " Anniversary",
                      style: TextStyle(
                        fontSize: Utils(context).getMediaWidth() * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.0)),
                  Container(
                    child: Card(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.height * 0.03),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0XFFE556EB), Color(0XFF5E08B3)])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                  MediaQuery.of(context).size.height * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                      Text(
                                        "Marriage Anniversary",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                      Text(
                                        "Love Anniversary",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                      Text(
                                        ":\t\t${userDetails.anniversaryDate??""}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                      Text(
                                        ":\t\t${userDetails.firstDate??""}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02)),
                  Container(
                    child: Text(
                      " Celebration",
                      style: TextStyle(
                        fontSize: Utils(context).getMediaWidth() * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.0)),
                  Container(
                    child: Card(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.height * 0.03),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0XFFE556EB), Color(0XFF5E08B3)])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                  MediaQuery.of(context).size.height * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                      Text(
                                        "Dog's Birthday",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                      Text(
                                        "Connors Birthday",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                      Text(
                                        ":\t\t13 Jun, 2014",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                      Text(
                                        ":\t\t13 Jun, 1994",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.02)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01)),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    child: Container(
                      child: Container(
                        width: double.infinity,
                        padding:
                        EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0XFF1A93EE), Color(0XFF6F34DD)]),
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "EDIT PROFILE",
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.height * 0.17,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0XFF5E08B3),
                            Color(0XFFE556EB),
                          ]),
                      shape: BoxShape.circle
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.1),
                      child: userDetails.picture != "0"
                          ? Image.network(
                        APP_ASSET_BASE_URL + userDetails.picture,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.height * 0.15,
                        errorBuilder: (context, error, straktress) {
                          return Image.asset(
                            "assets/profile_user.jpg",
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.height * 0.15,
                          );
                        },
                      )
                          : Image.asset(
                        "assets/profile_user.jpg",
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.height * 0.15,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

