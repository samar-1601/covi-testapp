import 'dart:async';
import 'package:flutter/material.dart';

class IconScreen extends StatefulWidget {
  @override
  _IconScreenState createState() => _IconScreenState();
}

class _IconScreenState extends State<IconScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Navigator.of(context).pushReplacementNamed('/welcome'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaScreen = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // appBar: AppBar(),
      body: Center(
        child: Container(
          child: Image.asset("assets/img/logo1.png"),
          height: mediaScreen.size.height * 0.5,
          width: mediaScreen.size.width * 0.5,
          // child: Image.asset(),
        ),
      ),
    );
  }
}

