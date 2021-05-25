import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'monitoring_questions_transition.dart';
import 'package:coviapp/shared_pref.dart';

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

  DateTime isolationDate;


  Widget buildFeverLevel() => buildTitle(
    title: 'Enter Your Temperature(in Celsius)?',
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
    title: 'Enter Your SpO2 Level?',
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

  Widget buildExtraHealthConditions() => buildTitle(
    title: 'How do you feel (any discomfort?)',
    child: TextFormField(
      initialValue: extraHealthCondition,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter data',
      ),
      onChanged: (data) => setState(() => this.extraHealthCondition = data),
    ),
  );


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

  void printValues(List<String> answers)
  {
    print("----------------- Answers Values ------------------\n");
    print("----------------- Answers Values End ------------------\n");
  }

  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();
  bool valueFromBack;
  String rollNo;

  Future putData(String feverTemp, String spo2, String extraHealthCondition) async {
    print("============inside PUTDATA in covid_data_sender\n");
    var url = Uri.parse('http://13.232.3.140:8080/submit_timestamp_data');
    rollNo = await _checkLoggedIn.getRollNo();
    int id = await _checkLoggedIn.getLoginIdValue();
    print(rollNo);
    print(id);
    Map data = {
      "Fever":feverTemp,
      "spo2":spo2,
      "condition" : extraHealthCondition,
      "rollNo" : rollNo,
    };
    String body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map responseBody = json.decode(response.body) as Map;
    print(responseBody);
    if (response.statusCode != 200) {
      // _checkLoggedIn.setVisitingFlag(true);
      valueFromBack = false;
    }
    else {
      valueFromBack = true;
    }
    print("inside set state for Monitoring question's response");
    print(valueFromBack);
    return valueFromBack;
  }

  @override
  void initState() {
    super.initState();
    buildFeverLevel();
    buildExtraHealthConditions();
    buildSpO2Level();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        'Please enter the following details so that our Doctors can monitor you',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: kWeirdBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  buildFeverLevel(),
                  const SizedBox(height: 12),
                  buildSpO2Level(),
                  const SizedBox(height: 12),
                  buildExtraHealthConditions(),
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
                valueFromBack = await putData(feverTemp, spo2, extraHealthCondition);
                print(valueFromBack);
                if(valueFromBack==true)
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
              },
            )
          ],
        ),
      ),
    );
  }
}

