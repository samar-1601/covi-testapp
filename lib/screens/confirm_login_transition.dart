import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/constants.dart';
// import 'package:coviapp/shared_pref.dart';


class LoginTransitionHelper extends StatefulWidget {
  final bool valueFromBack;


  LoginTransitionHelper(
      {this.valueFromBack,});

  @override
  _LoginTransitionHelperState createState() => _LoginTransitionHelperState();
}

class _LoginTransitionHelperState extends State<LoginTransitionHelper> {
  //CheckLoggedIn _checkLoggedIn = CheckLoggedIn();

void checkLogin()
{
  if(widget.valueFromBack==false)
    {
      AlertBox(
          context: context,
          alertContent:
          'Invalid UserName or Password. Try again.\nDont\'t have an account? SignUp',
          alertTitle: 'Invalid Entry !!',
          rightActionText: 'SignUp',
          leftActionText: 'Close',
          onPressingLeftActionButton: () {
            Navigator.of(context).pop();
          },
          onPressingRightActionButton: ()
          {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/signup', (Route<dynamic> route) => false);
          }
      ).showAlert();
    }
  else
    {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/doYouHaveCovid', (Route<dynamic> route) => false);
    }
}

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              //margin: EdgeInsets.only(top: 10.0,bottom: 20.0),
              color: kWeirdBlue,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),

                    Flexible(
                      flex: 9,
                      child: Container(
                        child: Text(
                          'CoviApp',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
//
                    Flexible(
                      flex: 3,
                      child: MaterialButton(
                        onPressed: () {
                          AlertBox(
                              context: context,
                              alertContent: 'Call and Mail us at ...',
                              alertTitle: 'Help',
                              rightActionText: 'Close',
                              leftActionText: '',
                              onPressingRightActionButton: () {
                                Navigator.pop(context);
                              }).showAlert();
                        },
                        child: Text(
                          'Help',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 80.0,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),

      // bottomNavigationBar: SizedBox(
      //   height: 80.0,
      //   child: CommonCustomBottomNavBar(),
      // ),
    );
  }
}
