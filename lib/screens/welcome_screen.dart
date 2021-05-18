import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaScreen = MediaQuery.of(context);
    // print('random');
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              child: Image.asset("assets/img/welcome.png"),
              height: mediaScreen.size.height * 0.5,
              width: mediaScreen.size.width * 0.5,
              // child: Image.asset(),
            ),
            Container(
              child: Text(
                " IIT Kharagpur \n Covid Helper app ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              width: 75.0,
              height: 75.0,
              child: new RawMaterialButton(
                fillColor: kWeirdBlue,
                shape: new CircleBorder(),
                elevation: 0.0,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                  size: 65.0,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/chooseCategory');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
