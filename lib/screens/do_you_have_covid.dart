import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/screens/general_covid_questions.dart';
import 'package:coviapp/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class DoYouHaveCovid extends StatefulWidget {
  final String selectedCategory;
  final String name;
  final String hall;
  final String room;
  final DateTime birthday;
  final String mobileNo1;
  final String mobileNo2;
  final String rollNo ;
  final String parentName ;
  final String parentMobileNo ;
  final int id ;

  DoYouHaveCovid(
      {this.id,this.selectedCategory,this.name, this.hall, this.room, this.birthday,
        this.rollNo, this.mobileNo1, this.mobileNo2, this.parentName, this.parentMobileNo});

  @override
  _DoYouHaveCovidState createState() => _DoYouHaveCovidState();
}

class _DoYouHaveCovidState extends State<DoYouHaveCovid> {

  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();
  bool valueFromBack;
  String rollNo;

  // Future sendSOS(int id) async {
  //   var url = Uri.parse('http://13.232.3.140:8080/sos');
  //   Map data = {
  //     "id":id,
  //   };
  //   String body = json.encode(data);
  //   print(body);
  //   var response = await http.post(url,
  //       headers: {"Content-Type": "application/json"}, body: body);
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //   Map responseBody = json.decode(response.body) as Map;
  //   print(responseBody);
  //   if (response.statusCode != 200) {
  //     // _checkLoggedIn.setVisitingFlag(true);
  //     setState(() {
  //       AlertBox(
  //           context: context,
  //           alertContent:
  //           'SOS was not sent',
  //           alertTitle: 'SOS Error !!',
  //           rightActionText: 'Close',
  //           leftActionText: '',
  //           onPressingRightActionButton: () async{
  //             bool alreadyAnswered = await _checkLoggedIn.getIfAnsweredBeforeFlag();
  //             if(alreadyAnswered==false)
  //             Navigator.pushNamedAndRemoveUntil(context, '/doYouHaveCovid', (route) => false);
  //             else
  //               Navigator.pushNamedAndRemoveUntil(context, '/monitoringQuestionsTransition', (route) => false);
  //           }).showAlert();
  //     });
  //   }
  //   else {
  //     //_checkLoggedIn.setVisitingFlag(true);
  //     setState(() {
  //       AlertBox(
  //           context: context,
  //           alertContent:
  //           'We have sent a mail to Covid Task Force with your details !!',
  //           alertTitle: 'ThankYou',
  //           rightActionText: 'Close',
  //           leftActionText: '',
  //           onPressingRightActionButton: () {
  //             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
  //                 DoYouHaveCovid(
  //                   id: widget.id,
  //                 )), (Route<dynamic> route) => false); }).showAlert();
  //     });
  //   }
  //   print("inside call for SOS");
  //   //idFromBack = responseBody['studentID'];
  //   // print(idFromBack);
  //   valueFromBack = await _checkLoggedIn.getVisitingFlag();
  //   print("=======");
  //   return valueFromBack;
  //   //print(idFromBack);
  // }

  @override
  void initState() {
    super.initState();
    print(widget.selectedCategory);
    if(widget.selectedCategory == 'Student')
    {
      print(widget.name==''?'Name not entered':widget.name);
      print(widget.rollNo==''?'roll not entered':widget.rollNo);
      print(widget.hall==''?'hall not entered':widget.hall);
      print(widget.mobileNo1==''?'mobile1 not entered':widget.mobileNo1);
      print(widget.mobileNo2==''?'mobile2 not entered':widget.mobileNo2);
      print(widget.parentName==''?'parent not entered':widget.parentName);
      print(widget.parentMobileNo==''?'parent No. not entered':widget.parentMobileNo);
      print(widget.birthday.toString()==''?'Name not entered':widget.birthday.toString());
    }
    else
    {
      print(widget.name==''?'Name not entered':widget.name);
      print(widget.hall==''?'Hall not entered':widget.hall);
      print(widget.selectedCategory=='Student'?widget.room:'');
      print(widget.birthday.toString()==''?'Name not entered':widget.birthday.toString());
    }

  }


  Future<void> _launched;
  String _phone = "8695571404";
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
              height: 120.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Center(
                child: Text(
                  'Are you infected with Covid (or have symptoms)?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: kWeirdBlue,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
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
                            'YES',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () async{
                    setState(() {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => CovidQuestions(
                                chosenCategory: widget.selectedCategory,
                                id : widget.id,
                              )));
                    });
                  },
                ),
                GestureDetector(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
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
                            'NO',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      AlertBox(
                          context: context,
                          alertContent:
                          'Please update your status in the app if you feel any covid symptoms',
                          alertTitle: 'Thank you for your cooperation ',
                          rightActionText: 'Close',
                          leftActionText: '',
                          onPressingRightActionButton: () {
                            Navigator.pop(context);
                          }).showAlert();
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              color: Colors.blueGrey[100],
              padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Center(
                child:RichText(
                  textAlign: TextAlign.center,
                  text: new TextSpan(
                    children: [
                      new TextSpan(
                        text: 'If you want to make Tele-consultation with BCRTH doctors, you can use the following ',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[800],
                        ),
                      ),
                      new TextSpan(
                        text: 'iMedix website',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          color: Colors.grey[900],
                        ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () { launch('https://imedixbcr.iitkgp.ac.in/iMediX/');
                          },
                      ),
                      new TextSpan(
                        text: ' and login using the same credentials.',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            GestureDetector(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.red,
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
                        'LogOut',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  AlertBox(
                      context: context,
                      alertContent:
                      'Do you want to Logout?',
                      alertTitle: 'Logout?',
                      rightActionText: 'Yes',
                      leftActionText: 'No',
                      onPressingLeftActionButton: (){
                        Navigator.pop(context);
                      },
                      onPressingRightActionButton: () {
                        _checkLoggedIn.setVisitingFlag(false);
                        _checkLoggedIn.setLoginIdValue(0);
                        _checkLoggedIn.setIfAnsweredBeforeFlag(false);
                        _checkLoggedIn.setRollNo("Your RollNo");
                        _checkLoggedIn.setNameToken(" Your Name");
                        _checkLoggedIn.setParentMbNoToken("Parent's Contact Number");
                        _checkLoggedIn.setParentNameToken("Parent's Name");
                        _checkLoggedIn.setMbNoToken("Your Mobile Number");
                        _checkLoggedIn.setHallToken("Your Hall of Residence");
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
                      }).showAlert();
                });
              },
            ),
          ],
        ),
      ),

        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
                heroTag: "profile",
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/profileView');
                }
            ),
            FloatingActionButton.extended(
                label: Text('SOS'),
                heroTag: "sos",
                icon: Icon(
                  Icons.call,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () async{
                  setState(() {
                    _makePhoneCall('tel:$_phone');
                  });
                }
            ),
          ],
        )
    );
  }
}
