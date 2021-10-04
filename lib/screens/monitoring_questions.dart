import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'monitoring_questions_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:coviapp/shared_pref.dart';
import 'package:coviapp/utilities/customAppBar.dart';

class MonitoringQuestions extends StatefulWidget {
  final String chosenCategory;
  final int id;
  final String rollNo;
  MonitoringQuestions({this.rollNo,this.id,this.chosenCategory});

  @override
  _MonitoringQuestionsState createState() => _MonitoringQuestionsState();
}

class _MonitoringQuestionsState extends State<MonitoringQuestions> {


  final formKey = GlobalKey<FormState>();

  String feverTemp = '';
  String spo2 = '';
  String extraHealthCondition = '';
  String haveFoodOrMedicalsupplies ='';
  String pulseRate = '';
  DateTime isolationDate;


  Widget buildFeverLevel() => buildTitle(
    title: 'Enter Your Temperature(in Fahrenheit)',
    child: TextFormField(
      initialValue: feverTemp,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter temperature',
      ),
      onChanged: (data) => setState(() => this.feverTemp = data),
    ),
  );
  Widget buildSpO2Level() => buildTitle(
    title: 'Enter Your SpO2 Level',
    child: TextFormField(
      initialValue: spo2,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Write your SpO2 Level',
      ),
      onChanged: (data) => setState(() => this.spo2 = data),
    ),
  );

  Widget buildPulseLevel() => buildTitle(
    title: 'Enter Your Pulse Rate',
    child: TextFormField(
      initialValue: pulseRate,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Write your Pulse Rate',
      ),
      onChanged: (data) => setState(() => this.pulseRate = data),
    ),
  );

  Widget buildExtraHealthConditions() => buildTitle(
    title: 'Add something in addition to above?',
    child: TextFormField(
      initialValue: extraHealthCondition,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Additional Discomforts',
      ),
      onChanged: (data) => setState(() => this.extraHealthCondition = data),
    ),
  );

  Widget buildHaveFoodOrMedicalSupplies() => buildTitle(
    title: 'Do you have proper food and medical supplies? (Yes/No).In case of No, please write your requirement.',
    child: TextFormField(
      initialValue: haveFoodOrMedicalsupplies,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter data',
      ),
      onChanged: (data) => setState(() => this.haveFoodOrMedicalsupplies = data),
    ),
  );


  Widget buildTitle({
    @required String title,
    @required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      );


  Map<String, bool> checkBoxValues = {
    'Breathing Difficulty' : false,
    'Body-ache' : false,
    'Headache': false,
    'Stomach disorder' : false,
    'Anxiety' : false,
  };

  var tmpString = '';

  getCheckboxItems(){

    checkBoxValues.forEach((key, value) {
      if(value == true)
      {
        tmpString += key + ', ';
      }
    });
  }

  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();
  bool valueFromBack;
  String rollNo;
  String msg='';

  Future putData(String feverTemp, String spo2, String extraHealthCondition, String haveFoodOrMedicalsupplies, pulseRate) async {
    print("============inside PUTDATA in monitoring data\n");
    var url = Uri.parse('https://imedixbcr.iitkgp.ac.in/api/coviapp/add-data');
    rollNo = await _checkLoggedIn.getRollNo();
    print(rollNo);
    print(token);

    Map data = {
      "fever":feverTemp,
      "spo2":spo2,
      "patient_condition" : extraHealthCondition.toLowerCase(),
      "food_supply":haveFoodOrMedicalsupplies,
      "pulse_rate":pulseRate,
    };
    String body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',}, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map responseBody = json.decode(response.body) as Map;
    print(responseBody);
    if (response.statusCode != 200) {
      valueFromBack = false;
    }
    else {
      valueFromBack = true;
    }
    print("puData in monitoring screen");
    print(" == token : {$token}");
    msg = responseBody["message"];
    print(" == msg : {$msg}");
    return valueFromBack??false;
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
    String type = responseBody["type"];

    if (response.statusCode == 200 && type == "PAT") {
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
      tmpString+= extraHealthCondition;
      extraHealthCondition = tmpString;
      print("tmpString : $tmpString");
    });
    await getID();
    await getToken();
    bool value = await putData(feverTemp, spo2, extraHealthCondition,haveFoodOrMedicalsupplies, pulseRate);
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
          value = await putData(feverTemp, spo2, extraHealthCondition,haveFoodOrMedicalsupplies, pulseRate);
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
    buildFeverLevel();
    buildExtraHealthConditions();
    buildSpO2Level();
    buildHaveFoodOrMedicalSupplies();
    buildPulseLevel();
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
        : Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            CustomAppBar(),
            SizedBox(
              height: 30.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Text(
                        'Your daily monitoring. The important vital signs will be transmitted in the real time to BCRTH doctor’s dashboard. In case of emergency, you can press SoS button. Kindly note that you will be prompted by the app to enter these details periodically. In case of standard values of these parameters, you must enter the same for the required period.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: kWeirdBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  buildFeverLevel(),
                  const SizedBox(height: 12),
                  buildSpO2Level(),
                  const SizedBox(height: 12),
                  buildPulseLevel(),
                  const SizedBox(height: 15),
                  Text(
                    "How Do you feel? (Any Discomfort)",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 15),
                  ListView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    children: checkBoxValues.keys.map((String key) {
                      return new CheckboxListTile(
                        title: new Text(key),
                        value: checkBoxValues[key],
                        activeColor: kWeirdBlue,
                        checkColor: Colors.white,
                        onChanged: (bool value) {
                          setState(() {
                            checkBoxValues[key] = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  buildExtraHealthConditions(),
                  const SizedBox(height: 12),
                  buildHaveFoodOrMedicalSupplies(),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    color: kWeirdBlue,
                    borderRadius: BorderRadius.circular(30.0),
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
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Proceed',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () async{
                getCheckboxItems();
                if(feverTemp=='')
                {
                  AlertBox(
                      context: context,
                      alertContent:
                      'Please Enter you Temperature. It is mandatory.',
                      alertTitle: 'Body temperature not entered !!',
                      rightActionText: 'Close',
                      leftActionText: '',
                      onPressingRightActionButton: () {
                        Navigator.pop(context);
                      }).showAlert();
                }
                else
                  {
                    bool value = false;
                    value = await checkFromBackend();
                    print("value == {$value}");
                    if(value==true)
                    {
                      setState(() {
                        AlertBox(
                            context: context,
                            alertContent:
                            'Thank You For entering your details. Please renter after 6 hours for continuous monitoring',
                            alertTitle: 'ThankYou',
                            rightActionText: 'Close',
                            leftActionText: '',
                            onPressingRightActionButton: () {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  MonitoringQuestionsTransitionScreen(
                                    selectedCategory: widget.chosenCategory,
                                    id: widget.id,
                                    rollNo: rollNo,
                                  )), (Route<dynamic> route) => false);
                            }).showAlert();
                      });
                    }
                    else
                    {
                      setState(() {
                        AlertBox(
                            context: context,
                            alertContent:
                            'The given details were not registered due to some error. Kindly Renter',
                            alertTitle: 'Entry Error !!',
                            rightActionText: 'Close',
                            leftActionText: '',
                            onPressingRightActionButton: () {
                              Navigator.pop(context);
                            }).showAlert();
                      });
                    }
                  }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.call,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          onPressed: () async{
            setState(() {
              _makePhoneCall('tel:$_phone');
            });
          }
      ),
    );
  }
}

