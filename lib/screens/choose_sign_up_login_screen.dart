import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/constants.dart';


class ChooseSignUpLoginScreen extends StatefulWidget {

  @override
  _ChooseSignUpLoginScreenState createState() => _ChooseSignUpLoginScreenState();
}

class _ChooseSignUpLoginScreenState extends State<ChooseSignUpLoginScreen> {


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
                              alertContent:
                              'Call and Mail us at ...',
                              alertTitle: 'Help',
                              rightActionText: 'Close',
                              leftActionText: '',
                              onPressingRightActionButton: () {
                                Navigator.pop(context);
                              }
                          ).showAlert();
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
              height: 250.0,
            ),
            GestureDetector(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: kWeirdBlue,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'LOG IN',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  Navigator.of(context).pushNamed('/login');
                });
              },
            ),
            SizedBox(
              height: 50.0,
            ),
            //===================================sign-Up commented=================================================
            // GestureDetector(
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: Container(
            //       width: MediaQuery.of(context).size.width * 0.5,
            //       decoration: BoxDecoration(
            //         color: kWeirdBlue,
            //         borderRadius: BorderRadius.circular(25.0),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.black26.withOpacity(0.3),
            //             spreadRadius: 1,
            //             blurRadius: 2,
            //             offset: Offset(0, 1), // changes position of shadow
            //           ),
            //         ],
            //       ),
            //       child: Center(
            //         child: Padding(
            //           padding: const EdgeInsets.all(10.0),
            //           child: Text(
            //             'SIGN UP',
            //             style: TextStyle(
            //               fontSize: 24.0,
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            //   onTap: () {
            //     setState(() {
            //       Navigator.of(context).pushNamed('/chooseCategory');
            //     });
            //   },
            // ),
            // SizedBox(
            //   height: 80.0,
            //),
            //=========================== SIGN UP COMMENT ENDS ===================================
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
