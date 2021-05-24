import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/screens/do_you_have_covid.dart';
//import 'package:coviapp/screens/monitoring_questions_transition.dart';
import 'package:coviapp/shared_pref.dart';
import 'package:coviapp/screens/choose_category.dart';

class WelcomeScreen extends StatelessWidget {

  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();

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
                onPressed: () async{
                  bool visited = await _checkLoggedIn.getVisitingFlag();
                  bool alreadyAnswered = await _checkLoggedIn.getIfAnsweredBeforeFlag();
                  if(visited==true)
                    {
                      if(alreadyAnswered==false)
                        {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              DoYouHaveCovid()), (Route<dynamic> route) => false);
                        }
                      else
                        {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (BuildContext context) =>ChooseCategory(),
                            ),
                          );
                        }
                    }
                  else
                    {// visiting first time
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/signup', (Route<dynamic> route) => false);
                    }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

