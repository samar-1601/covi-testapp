import 'package:coviapp/screens/do_you_have_covid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coviapp/screens/confirm_login_transition.dart';


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

  Widget buildRollOrEcNumber() => buildTitle(
    title: 'Roll/EC Number',
    child: TextFormField(
      initialValue: rollNo,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter data',
      ),
      onChanged: (data) => setState(() => this.rollNo = data),
    ),
  );

  Widget buildMobile1() => buildTitle(
    title: 'Registered Mobile Number',
    child: TextFormField(
      initialValue: mobileNo1,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter data',
      ),
      onChanged: (data) => setState(() => this.mobileNo1 = data),
    ),
  );

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

  bool valueFromBack;

  Future checkPassword (String password, String mobileNo, String rollNo) async {
    var url = Uri.parse('http://13.232.3.140:8080/login');
    print(mobileNo);
    print(password);
    print("ONN LOOGGIINNN SCCRREESSNN-----------------------------\n");
    Map data = {
      "password": password,
      "mobileNo1": mobileNo,
      "rollNo": rollNo,
    };
    String body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map responseBody = json.decode(response.body) as Map;
    if (response.statusCode == 200) {
      _checkLoggedIn.setVisitingFlag(true);
    } else {
      _checkLoggedIn.setVisitingFlag(false);
    }
    print(_checkLoggedIn.getVisitingFlag());
    valueFromBack = await _checkLoggedIn.getVisitingFlag();
    idFromBack = responseBody['id'];
    print(idFromBack);
    // setState(() async{
    //   valueFromBack = await _checkLoggedIn.getVisitingFlag();
    //   print("=====================\n");
    //   print(valueFromBack);
    //   print("=====================\n");
    // });
    return valueFromBack;
  }


  Widget buildTitle({
    @required String title,
    @required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          child,
        ],
      );
  @override
  void initState() {
    super.initState();
    buildRollOrEcNumber();
    buildMobile1();
    buildPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              height: 50.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Text(
                        'Enter Your Details',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  buildRollOrEcNumber(),
                  const SizedBox(height: 12),
                  buildMobile1(),
                  const SizedBox(height: 12),
                  buildPassword(),
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
                bool value = await checkPassword(password, mobileNo1, rollNo);
                if(value==true)
                  {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        DoYouHaveCovid(
                          id: idFromBack,
                        )), (Route<dynamic> route) => false);
                  }
                else
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
                // setState((){
                //   Navigator.push(
                //       context,
                //       new MaterialPageRoute(
                //           builder: (BuildContext context) => LoginTransitionHelper(
                //             valueFromBack: valueFromBack,
                //           )));
                // });
              },
            )
          ],
        ),
      ),
    );
  }
}
