import 'dart:io';

import 'package:flutter/material.dart';
import 'utilities/constants.dart';
import 'route_generator.dart';
import 'notifications_manager.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {

  HttpOverrides.global = new MyHttpOverrides();

  // from notifications manager
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.


  static Map<int, Color> color = {
    50: Color.fromRGBO(57,73,171, .1),
    100: Color.fromRGBO(57,73,171, .2),
    200: Color.fromRGBO(57,73,171, .3),
    300: Color.fromRGBO(57,73,171, .4),
    400: Color.fromRGBO(57,73,171, .5),
    500: Color.fromRGBO(57,73,171, .6),
    600: Color.fromRGBO(57,73,171, .7),
    700: Color.fromRGBO(57,73,171, .8),
    800: Color.fromRGBO(57,73,171, .9),
    900: Color.fromRGBO(57,73,171, 1),
  };

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialColor colorCustom = MaterialColor(0xFFC30000, MyApp.color);

  @override
  void initState() {
    notificationsManager(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoviApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.white,
        primarySwatch: colorCustom,
        accentColor: kWeirdBlue,
        backgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Color(0xFFEF5553),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontSize: 18,
          ),
          headline5: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
          bodyText1: TextStyle(
            color: Colors.pink,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      
    );
  }
}
