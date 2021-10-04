import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/utilities/customAppBar.dart';

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
           CustomAppBar(),
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
