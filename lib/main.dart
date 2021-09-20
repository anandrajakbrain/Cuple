import 'package:cuple_app/componets/noInterNetConnectionScreen.dart';
import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/configuration/plug.dart';
import 'package:cuple_app/configuration/utils.dart';
import 'package:cuple_app/screens/home_screen.dart';
import 'package:cuple_app/screens/ideasListScreen.dart';
import 'package:cuple_app/screens/login.dart';
import 'package:cuple_app/screens/myWishList.dart';
import 'package:cuple_app/screens/notificationListScreen.dart';
import 'package:cuple_app/screens/otpVerficationScreen.dart';
import 'package:cuple_app/screens/partnerWishList.dart';
import 'package:cuple_app/screens/registerScreen.dart';
import 'package:cuple_app/screens/reminderListScreen.dart';
import 'package:cuple_app/screens/settings_screen.dart';
import 'package:cuple_app/screens/tipsListScreen.dart';
import 'package:cuple_app/screens/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:splashscreen/splashscreen.dart';

import 'model/fireBaseItemModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: APP_NAME),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
Widget nextWidget=Container(
  color: APP_BAR_COLOR,
);
  List<NotificationDataModel> notidata = [];
  final Map<String, Item> _items = <String, Item>{};
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
getWidget() async{
    Widget temp;
    temp=await Utils(context).checkUser();
    setState(() {
      nextWidget=temp;
    });

}
toekData()async{
  await Utils(context).getToken();
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toekData();
    getWidget();

    try {


      var initializationSettingsAndroid =
      new AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = new IOSInitializationSettings();
      var initializationSettings = new InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: onSelectNotification);

     Utils(context).firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("On message: $message");
          Item _item = _itemForMessage(message);
          try {
            _showNotification(flutterLocalNotificationsPlugin,
                title: message['notification']['title'],
                message: message['notification']['body']);
            // setState(() {
            notidata.add(NotificationDataModel(
              title: message['notification']['title'],
              message: message['notification']['body'],
            ));
            // });
          } catch (e, s) {
            print(e);
            print(s);
          }
          return;
        },
        onLaunch: (Map<String, dynamic> message) async {
          // print("On Launch: $message");
          // print(message);//_showItemDailog(message);
          Item _item = _itemForMessage(message);
          print("Click Work");
          // _showNotification(int.parse(_item.itemId), "${_item.status}", "GET description FROM message OBJECT", "GET PAYLOAD FROM message OBJECT");
          // _showItemDailog(message);
        },
        onResume: (Map<String, dynamic> message) async {
          print("On Resume: $message");

          // _showItemDailog(message);
          Item _item = _itemForMessage(message);

          // _showNotification(int.parse(_item.itemId), "${_item.status}", "GET description FROM message OBJECT", "GET PAYLOAD FROM message OBJECT");
          // _showItemDailog(message);
        },
      );
      // _configureDidReceiveLocalNotificationSubject();
      // _configureSelectNotificationSubject();
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Item _itemForMessage(Map<String, dynamic> message) {
    final dynamic data = message['data'] ?? message;
    final String itemId = data['id'];
    final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
      ..status = data['status'];
    return item;
  }
  Future onSelectNotification(String payload) async {
    try {
      /*Do whatever you want to do on notification click. In this case, I'll show an alert dialog*/
      // showDialog(
      //   context: context,
      //   builder: (_) => AlertDialog(
      //     title: Text(payload),
      //     content: Text("Payload: $payload"),
      //   ),
      // );
      //

      // Widget nextWidget = await UtilitiesMethods(context).getInitialWidget();
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => nextWidget));
      //
      //
      //
      //

      // _MyHomePageState.scaffoldKey.currentState.dispose();

//
//       showDialog(
//         context: context,
//         builder: (_) {
//           return new AlertDialog(
//             title: Text("PayLoad"),
//             content: Text("Payload : $payload"),
//           );
//         },
//       );
//       if (mounted) GotoDashboard();
      print("Select Noti Click trigger");
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
  Future _showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      {String title,
        message}) async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", title, message,
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
    new NotificationDetails(android: androidDetails, iOS: iSODetails);

    await flutterLocalNotificationsPlugin.show(
        0, "$title", "$message", generalNotificationDetails,
        payload: "Task");
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // if (Utils(context).checkInternet() == true) {
      return SplashScreen(
          seconds: 20,
          navigateAfterSeconds: nextWidget,
          // navigateAfterFuture: Utils(context).checkUser(),
          // new LoginScreen(),
          // title: new Text(
          //   APP_NAME,
          //   style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          // ),
          // image: new Image.asset('assets/img1.png'),
          backgroundColor: Colors.white,
          imageBackground: AssetImage("assets/img1.png"),
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 150,
          loaderColor: Colors.red);

  }
}
class NotificationDataModel {
  String title;
  String message;
  NotificationDataModel({this.message, this.title});
}