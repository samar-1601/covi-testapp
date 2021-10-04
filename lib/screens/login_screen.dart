import 'package:coviapp/screens/do_you_have_covid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coviapp/screens/choose_category.dart';
import 'monitoring_questions_transition.dart';
import 'package:coviapp/utilities/customAppBar.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();


  final formKey = GlobalKey<FormState>();
  String rollNo = '';
  String mobileNo1 = '';
  String password = '';
  int idFromBack;
  bool acceptedTerms = false;

  Widget buildRollOrEcNumber() => buildTitle(
    title: 'Username',
    child: TextFormField(
      initialValue: rollNo,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Username',
      ),
      onChanged: (data) => setState(() => this.rollNo = data),
    ),
  );

  // Widget buildMobile1() => buildTitle(
  //   title: 'Registered Mobile Number',
  //   child: TextFormField(
  //     initialValue: mobileNo1,
  //     keyboardType: TextInputType.phone,
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(),
  //       hintText: 'Enter data',
  //     ),
  //     onChanged: (data) => setState(() => this.mobileNo1 = data),
  //   ),
  // );

  Widget buildPassword() => buildTitle(
    title: 'Enter password',
    child: TextFormField(
      initialValue: password,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter your password',
      ),
      onChanged: (data) => setState(() => this.password= data),
    ),
  );

  String otp ="";
  String ifPreviouslyLoggedIn;
  bool valueFromBack;
  String hasUserAnsweredDoYouHaveCovidBefore;
  String token = "";
  bool _loading = false;
  Future checkPassword (String password, String mobileNo, String rollNo) async {
    setState(() {
      _loading = true;
    });
    var url = Uri.parse('https://imedixbcr.iitkgp.ac.in/api/user/login');
    //print(mobileNo);
    print(password);
    print("ONN LOOGGIINNN SCCRREESSNN-----------------------------\n");
    Map data = {
      "password": password,
      //mobileNo1": mobileNo,
      "username": rollNo,
    };
    String body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map responseBody = json.decode(response.body) as Map;
    String type = responseBody["type"];

    if (response.statusCode == 200 && type == "PAT") {
      _checkLoggedIn.setVisitingFlag(true);
      _checkLoggedIn.setRollNo(rollNo);
      _checkLoggedIn.setPasswordToken(password);
    } else {
      _checkLoggedIn.setVisitingFlag(false);
    }
    print(_checkLoggedIn.getVisitingFlag());
    valueFromBack = await _checkLoggedIn.getVisitingFlag();
    ifPreviouslyLoggedIn = responseBody['hasPatientData'];
    hasUserAnsweredDoYouHaveCovidBefore = responseBody['hasCovidData'];
    token = responseBody['jwtToken'];

    print(" == ifPrevLoggedIn Successfully : ${ifPreviouslyLoggedIn}");
    print(" == token : {$token}");
    print(" == has answered before? : {$hasUserAnsweredDoYouHaveCovidBefore}");

    _checkLoggedIn.setLoginToken(token);
    _checkLoggedIn.setRollNo(rollNo);
    _checkLoggedIn.setPasswordToken(password);
    print("Value Form Back = ${valueFromBack}");
    setState(() {
      _loading = false;
    });
    return valueFromBack??false;
  }


  Widget buildTitle({
    @required String title,
    @required Widget child,
    String leftText,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [

              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                '*',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
  @override
  void initState() {
    super.initState();
    buildRollOrEcNumber();
    //buildMobile1();
    buildPassword();
  }

  @override
  Widget build(BuildContext context) {
    return (_loading == true)
        ? Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: new AlwaysStoppedAnimation<Color>(kWeirdBlue),
        ),
      ),
    )
        :Scaffold(
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            CustomAppBar(),
            SizedBox(
              height: 30.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Text(
                        'Login Details are shared with you in your email. Kindly use that information.\n',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  buildRollOrEcNumber(),
                  const SizedBox(height: 12),
                  buildPassword(),
                  const SizedBox(height: 12),
              Container(
                color: Colors.blueGrey[100],
                padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: CheckboxListTile(
                  title: RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: 'I agree to use this app for Covid-19 monitoring by BC Roy Technology Hospital, IIT Kharagpur.',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[800],
                          ),
                        ),
                        new TextSpan(
                          text: ' This app is only for the beneficiaries of the BC Roy Technology Hospital IIT Kharagpur.',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                  value: acceptedTerms,
                  activeColor: kWeirdBlue,
                  checkColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      acceptedTerms = value;
                    });
                  },
                ),
              ),
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
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
                        'Proceed',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () async{
                bool value = false;
                value = await checkPassword(password, mobileNo1, rollNo);
                print("value after checking password = ${value}");

                if(value==true && acceptedTerms==true)
                  {
                    _checkLoggedIn.setRollNo(rollNo);
                    _checkLoggedIn.setPasswordToken(password);
                    if(ifPreviouslyLoggedIn=="yes")
                      {
                        if(hasUserAnsweredDoYouHaveCovidBefore=="yes")
                          {
                            _checkLoggedIn.setIfAnsweredBeforeFlag(true);
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                MonitoringQuestionsTransitionScreen(
                                  rollNo: rollNo,
                                )), (Route<dynamic> route) => false);
                          }
                        else
                          {
                            _checkLoggedIn.setIfAnsweredBeforeFlag(false);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => DoYouHaveCovid(
                                    rollNo: rollNo,
                                  )
                              ),
                                  (route) => false,
                            );
                          }
                      }
                    else
                      {
                        _checkLoggedIn.setVisitingFlag(false);
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            ChooseCategory(
                              // id: idFromBack,
                            )), (Route<dynamic> route) => false);
                      }
                  }
                else {
                  if(value==false)
                  AlertBox(
                    context: context,
                    alertContent:
                    'Invalid UserName or Password. Try again',
                    alertTitle: 'Invalid Entry !!',
                    rightActionText: 'Close',
                    leftActionText: ' ',
                    onPressingRightActionButton: () {
                      Navigator.of(context).pop();
                      _checkLoggedIn.setVisitingFlag(false);
                    },
                  ).showAlert();
                  else if(acceptedTerms==false)
                    {
                      AlertBox(
                        context: context,
                        alertContent:
                        'We cannot proceed with login if the you dont accept the terms.',
                        alertTitle: 'Terms and Conditions',
                        rightActionText: 'Close',
                        leftActionText: ' ',
                        onPressingRightActionButton: () {
                          Navigator.of(context).pop();
                          _checkLoggedIn.setVisitingFlag(false);
                        },
                      ).showAlert();
                    }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
