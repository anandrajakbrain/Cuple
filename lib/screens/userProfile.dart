// import 'package:cuple_app/componets/customMenuButton.dart';
// import 'package:cuple_app/configuration/app_config.dart';
// import 'package:cuple_app/configuration/utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
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
