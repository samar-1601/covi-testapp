import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/screens/do_you_have_covid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:otp_text_field/otp_text_field.dart';
import 'package:coviapp/shared_pref.dart';
import 'package:coviapp/utilities/customAppBar.dart';

class GeneralDataSender extends StatefulWidget {
  final String selectedCategory;
  final String name;
  final String hall;
  final String room;
  final DateTime birthday;
  final String mobileNo1;
  final String mobileNo2;
  final String rollNo;
  final String parentName;
  final String parentMobileNo;
  final String email;
  final String password;

  GeneralDataSender(
      {this.selectedCategory = 'NE',
      this.name = 'NE',
      this.hall = 'NE',
      this.room = 'NE',
      this.birthday,
      this.rollNo = 'NE',
      this.mobileNo1 = 'NE',
      this.mobileNo2 = 'NE',
      this.parentName = 'NE',
      this.parentMobileNo = 'NE',
      this.email = 'NE',
        this.password = 'NE'});

  @override
  _GeneralDataSenderState createState() => _GeneralDataSenderState();
}

class _GeneralDataSenderState extends State<GeneralDataSender> {
  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();
  bool valueFromBack;
  //int idFromBack;
  String msg='';

  Future putData() async {
    var url = Uri.parse('https://imedixbcr.iitkgp.ac.in/api/coviapp/update-patient-detail');
    Map data = {
      "name": widget.name,
      "hall": widget.hall,
      //"birth_date": widget.birthday.toString(),
      "selected_category": widget.selectedCategory,
      "mobileNo1" : widget.mobileNo1,
      //"rollNo" : widget.rollNo,
      //"parentName" : widget.parentName,
      "parent_mobileno": widget.parentMobileNo,
      //"password": widget.password,
    };
    String body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',}, body: body,);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map responseBody = json.decode(response.body) as Map;
    if (response.statusCode != 200) {
      _checkLoggedIn.setVisitingFlag(false);
      _checkLoggedIn.setIfAnsweredBeforeFlag(false);
     }
       else {
       _checkLoggedIn.setVisitingFlag(true);
     }
    print("puData in general data_and_otp");
    valueFromBack = await _checkLoggedIn.getVisitingFlag();
    print(" == token : {$token}");
    msg = responseBody["status"];
    print(" == msg : {$msg}");
    return valueFromBack??false;
  }

  Future checkPassword (String password, String mobileNo, String rollNo) async {
    var url = Uri.parse('https://imedixbcr.iitkgp.ac.in/api/user/login');
    print(mobileNo);
    print(password);
    print("Sending Login details to get new token\n");
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
    if (response.statusCode == 200) {
      _checkLoggedIn.setVisitingFlag(true);
      _checkLoggedIn.setRollNo(rollNo);
    } else {
      _checkLoggedIn.setVisitingFlag(false);
    }

    token = responseBody['jwtToken'];
    print(" == ifPrevLoggedIn Successfully : ");
    print(" == New Token : {$token}");
    _checkLoggedIn.setLoginToken(token);
    valueFromBack = await _checkLoggedIn.getVisitingFlag();
    print(valueFromBack);
    return valueFromBack??false;
  }

  String studentRollNo;
  Future getID() async
  {
     var tempStudentRollNo = await _checkLoggedIn.getRollNo();
    setState(() {
      studentRollNo = tempStudentRollNo;
    });
  }
  String token;
  Future getToken() async
  {
    var tempToken= await _checkLoggedIn.getLoginToken();
    setState(() {
      token = tempToken;
    });

  }

  bool _loading=false;
  Future checkFromBackend() async{
    setState(() {
      _loading=true;
    });
    await getID();
    await getToken();
    bool value = await putData();
    if(value==false)
      {
        if(msg=="token has expired")
        {
          print("-------inside token has expired if---------------");
          print(" == Old Token : {$token}");
          String passwordFromSF = await _checkLoggedIn.getPasswordToken();
          String rollNoFromSF = await _checkLoggedIn.getRollNo();
          String mobileNoTemp = "1234567890";
          print("PasswordFromSF = ${passwordFromSF} ,RollNoFromSF = ${rollNoFromSF} ");
          bool value2 = await checkPassword(passwordFromSF, mobileNoTemp, rollNoFromSF);
          print("value after checking password for new token = ${value2}");
          print(" == New Token : {$token}");
          if(value2==true)
          {
            value = await putData();
            if(value == true)
            {
              setState(() {
                _loading = false;
              });
            }
            else
            {
              setState(() {
                _loading= false;
              });
            }
          }
        }
        else
          {
            setState(() {
              _loading= false;
              AlertBox(
                context: context,
                alertContent:
                'Server Error. Please try again after sometime',
                alertTitle: 'Server Error !!',
                rightActionText: 'Close',
                leftActionText: ' ',
                onPressingRightActionButton: () {
                  Navigator.of(context).pop();
                  _checkLoggedIn.setVisitingFlag(false);
                },
              ).showAlert();
            });
          }
      }
    else
      {
        setState(() {
          _loading = false;
        });
      }
    return value;
  }

  @override
  void initState() {
    super.initState();
    print(widget.selectedCategory);
      //checkFromBackend();
      print(widget.name);
      print(widget.rollNo);
      print(widget.email);
      print(widget.hall);
      print(widget.mobileNo1);
     // print(widget.mobileNo2);
      print(widget.birthday.toString());
  }

  @override
  Widget build(BuildContext context) {
    return (_loading == true)
        ? Scaffold(
        body: Center(
          child: CircularProgressIndicator(
          backgroundColor: Colors.white,
            color: kWeirdBlue,
      ),
        ),
    )
        : Scaffold(
            body: Container(
              //margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  CustomAppBar(),
                  SizedBox(
                    height: 80.0,
                  ),
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Data Entered by You\n',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.selectedCategory +
                                '\n' +
                                widget.name +
                                '\n' +
                                widget.rollNo +
                                '\n' +
                                widget.hall +
                                '\n' +
                                widget.mobileNo1 +
                                '\n' +
                                widget.parentName +
                                '\n' +
                                widget.parentMobileNo +
                                '\n' +
                                widget.birthday.toString(),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
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
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Confirm',
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
                      value = await checkFromBackend();
                      print("value == {$value}");
                      setState(() {
                          //checkOTP(otp,idFromBack);
                          if(value==true)
                            {
                              _checkLoggedIn.setVisitingFlag(true);
                              _checkLoggedIn.setHallToken(widget.hall);
                              _checkLoggedIn.setNameToken(widget.name);
                              _checkLoggedIn.setMbNoToken(widget.mobileNo1);
                              _checkLoggedIn.setParentNameToken(widget.parentName);
                              _checkLoggedIn.setParentMbNoToken(widget.parentMobileNo);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => DoYouHaveCovid(
                                      selectedCategory: widget.selectedCategory,
                                    )
                                ),
                                    (route) => false,
                              );
                            }
                          else
                            {
                              _checkLoggedIn.setVisitingFlag(false);
                              _checkLoggedIn.setRollNo("value");
                              _checkLoggedIn.setIfAnsweredBeforeFlag(false);
                              AlertBox(
                                  context: context,
                                  alertContent:
                                  'The given details are not found in Institute Database',
                                  alertTitle: 'Invalid Entry !!',
                                  rightActionText: 'Close',
                                  leftActionText: '',
                                  onPressingRightActionButton: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('/studentChosen', (Route<dynamic> route) => false);
                                  }).showAlert();
                            }
                      });
                    },
                  ),
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


//

// ================================== Removed OTP part ===================
// const SizedBox(height: 30),
// Align(
//   alignment: Alignment.center,
//   child: Container(
//     child: Text(
//        'Enter OTP',
//       textAlign: TextAlign.left,
//       style: TextStyle(
//         fontSize: 22.0,
//         fontWeight: FontWeight.bold,
//         color: kWeirdBlue,
//       ),
//     ),
//   ),
// ),
// const SizedBox(height: 25),
// OTPTextField(
//   length: 6,
//   width: MediaQuery.of(context).size.width*0.7,
//   fieldWidth: 50,
//   style: TextStyle(
//       fontSize: 20,
//   ),
//   textFieldAlignment: MainAxisAlignment.center,
//   fieldStyle: FieldStyle.underline,
//   onCompleted: (pin) {
//     print("Completed: " + pin);
//     otp = pin;
//   },
// ),
// SizedBox(
//   height: 30.0,
// ),
//=============================== Removed OTP Part =========================

// String otp ="";
// Future checkOTP(String otp, int id) async {
//   var url = Uri.parse('http://13.232.3.140:8080/verify');
//   print(id);
//   print(otp);
//   Map data = {
//     "otp": otp,
//     "id":id,
//   };
//   String body = json.encode(data);
//   print(body);
//   var response = await http.post(url,
//       headers: {"Content-Type": "application/json"}, body: body);
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');
//   if (response.statusCode == 200) {
//     _checkLoggedIn.setVisitingFlag(true);
//   } else {
//     _checkLoggedIn.setVisitingFlag(false);
//   }
//   print(_checkLoggedIn.getVisitingFlag());
//   setState(() async{
//     valueFromBack = await _checkLoggedIn.getVisitingFlag();
//   });
// }