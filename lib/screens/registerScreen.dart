import 'package:cuple_app/configuration/app_config.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_PRIMARY_COLOR,
      body: Container(
        child: Column(
          children: [
            Text("Create An Account"),
          ],
        ),
      ),
    );
  }
}
