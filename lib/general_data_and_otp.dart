import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/screens/do_you_have_covid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:otp_text_field/otp_text_field.dart';
import 'package:coviapp/shared_pref.dart';
//import 'package:otp_text_field/style.dart';

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
  int idFromBack;

  Future putData() async {
    var url = Uri.parse('http://13.232.3.140:8080/submit_form');
    Map data = {
      "name": widget.name,
      "hall": widget.hall,
      "birth_date": "birthday",
      "selectedCategory": "",
      "room":"",
      "mobileNo1" : widget.mobileNo1,
      "mobileNo2" : " ",
      "rollNo" : widget.rollNo,
      "parentName" : " ",
      "parentMobileNo": "",
      "email": " ",
      "password": widget.password,
    };
    String body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map responseBody = json.decode(response.body) as Map;
    if (response.statusCode != 200) {
      _checkLoggedIn.setVisitingFlag(false);
      _checkLoggedIn.setIfAnsweredBeforeFlag(false);
      setState(() {
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
      });
     }
       else {
       _checkLoggedIn.setVisitingFlag(true);
     }
    print("inside set state for ID response");
    idFromBack = responseBody['studentID'];
    print(idFromBack);
    valueFromBack = await _checkLoggedIn.getVisitingFlag();
    setState((){
      idFromBack = responseBody['studentID'].toInt();
      _checkLoggedIn.setLoginIdValue(idFromBack);
    });
    print("=======");
    print(idFromBack);
  }


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

  String studentRollNo;
  Future getID() async
  {
    studentRollNo = await _checkLoggedIn.getRollNo();
  }

  @override
  void initState() {
    super.initState();
    print(widget.selectedCategory);
  getID();
    if (widget.selectedCategory == 'Student') {
      print(widget.name);
      print(studentRollNo);
      print(widget.email);
      print(widget.hall);
      print(widget.mobileNo1);
      print(widget.mobileNo2);
      print(widget.parentName);
      print(widget.parentMobileNo);
      print(widget.birthday.toString());
    } else {
      print(widget.name);
      print(widget.rollNo);
      print(widget.email);
      print(widget.hall);
      print(widget.mobileNo1);
      print(widget.mobileNo2);
      print(widget.birthday.toString());
    }
    putData();

  }

  @override
  Widget build(BuildContext context) {
    return (valueFromBack == false)
        ? Scaffold(
        body: Center(
          child: CircularProgressIndicator(
          backgroundColor: Colors.white,
      ),
        ),
    )
        : Scaffold(
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
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Data till now\n',
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
                                widget.room +
                                '\n' +
                                widget.mobileNo1 +
                                '\n' +
                                widget.mobileNo2 +
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
                    onTap: () {
                      setState(() {
                          //checkOTP(otp,idFromBack);
                          if(valueFromBack==true)
                            {
                              _checkLoggedIn.setVisitingFlag(true);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => DoYouHaveCovid(
                                      selectedCategory: widget.selectedCategory,
                                      id: idFromBack,
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
