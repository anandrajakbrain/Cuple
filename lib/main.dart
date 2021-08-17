import 'package:cuple_app/configuration/app_config.dart';
import 'package:cuple_app/screens/home_screen.dart';
import 'package:cuple_app/screens/ideasListScreen.dart';
import 'package:cuple_app/screens/myWishList.dart';
import 'package:cuple_app/screens/notificationListScreen.dart';
import 'package:cuple_app/screens/otpVerficationScreen.dart';
import 'package:cuple_app/screens/partnerWishList.dart';
import 'package:cuple_app/screens/registerScreen.dart';
import 'package:cuple_app/screens/reminderListScreen.dart';
import 'package:cuple_app/screens/settings_screen.dart';
import 'package:cuple_app/screens/tipsListScreen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return HomeScreen();
    return SplashScreen(
        seconds: 10,
        navigateAfterSeconds: new RegisterScreen(),
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
