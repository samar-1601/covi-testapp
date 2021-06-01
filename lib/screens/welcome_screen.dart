import 'package:coviapp/screens/monitoring_questions_transition.dart';
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
      body: Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                child: Image.asset("assets/img/welcome1.png"),
                height: mediaScreen.size.height * 0.4,
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
                margin: EdgeInsets.only(top: 40.0),
                width: 60.0,
                height: 60.0,
                child: new RawMaterialButton(
                  fillColor: kWeirdBlue,
                  shape: new CircleBorder(),
                  elevation: 0.0,
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                    size: 45.0,
                  ),
                  onPressed: () async{
                    bool visited = await _checkLoggedIn.getVisitingFlag();
                    bool alreadyAnswered = await _checkLoggedIn.getIfAnsweredBeforeFlag();
                    String rollNo = await _checkLoggedIn.getRollNo();
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
                                builder: (BuildContext context) =>MonitoringQuestionsTransitionScreen(
                                  rollNo: rollNo,
                                ),
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
              Container(
                margin: EdgeInsets.only(top:40),
                height: 100,
               color: Colors.grey[200],
               width:  mediaScreen.size.height * 0.95,
               child: Column(
                 children: [
                   Expanded(
                     child:Padding(
                       padding: const EdgeInsets.only(top:12),
                       child: Text(
                         'Copyright ©2021 IIT Kharagpur, All Rights Reserved.',
                         style: TextStyle(
                             fontWeight:FontWeight.w400,
                             fontSize: 13.0,
                             color: Color(0xFF162A49)
                         ),
                       ),
                     ),
                   ),
                   Expanded(
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(
                         'CoviApp team : Samar Pratap Singh, Saksham Arya, Abhinandan De, Aryan Singh, Kunal Singh, Sayantan Das',
                         style: TextStyle(
                             fontWeight:FontWeight.w300,
                             fontSize: 12.0,
                             color: Color(0xFF162A49)
                         ),
                         textAlign: TextAlign.center,
                       ),
                     ),
                   ),
                 ],
               ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

