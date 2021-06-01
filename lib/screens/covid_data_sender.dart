import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/screens/monitoring_questions_transition.dart';
//import 'package:coviapp/screens/do_you_have_covid.dart';
import 'package:coviapp/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coviapp/utilities/customAppBar.dart';

class CovidDataSender extends StatefulWidget {

  final String selectedCategory;
  final String name;//
  final String hall;
  final String room;
  final DateTime birthday;//
  final String mobileNo1;//
  final String mobileNo2;
  final String rollNo ;//
  final String parentName ;
  final String parentMobileNo ;//
  final String email;//
  final String password;
  final String isolationAddress ;
  final String supervisorName ;
  final String dsaCouncilMemberName1 ;
  final String dsaCouncilMemberName2;
  final String dsaCouncilMember1MbNo ;
  final String dsaCouncilMember2MbNo ;
  final String supervisorMobileNo ;
  final String seekHelp;
  final String symptoms ;
  final int id;

  DateTime isolationDate;
  final List<String> areYouEquippedQuestions;
  final List<String> wellBeingQuestions;
  final List<String> areYouEquippedAnswers;
  final List<String> wellBeingAnswers;

  CovidDataSender(
      {this.id,this.password='NE',this.symptoms ='NE',this.seekHelp,this.isolationDate,this.dsaCouncilMemberName1,this.dsaCouncilMemberName2='NE',this.supervisorName ='NE',this.isolationAddress='NE',this.supervisorMobileNo='NE',this.dsaCouncilMember1MbNo='NE',this.dsaCouncilMember2MbNo='NE',this.areYouEquippedQuestions ,this.areYouEquippedAnswers,this.wellBeingQuestions,this.wellBeingAnswers,this.selectedCategory = 'NE',this.name = 'NE', this.hall = 'NE', this.room = 'NE', this.birthday,
        this.rollNo = 'NE', this.mobileNo1 = 'NE', this.mobileNo2 ='NE', this.parentName = 'NE', this.parentMobileNo= 'NE', this.email = 'NE'});

  @override
  _CovidDataSenderState createState() => _CovidDataSenderState();
}

class _CovidDataSenderState extends State<CovidDataSender> {

  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();
  bool valueFromBack;
  String rollNo;
  String msg ='';

  Future putData() async {
    print("============inside PUTDATA in covid_data_sender\n");
    var url = Uri.parse('https://imedixbcr.iitkgp.ac.in/api/coviapp/update-covid-detail');
    rollNo = await _checkLoggedIn.getRollNo();
    print(rollNo);
    print(token);
    Map data = {
      //"selectedCategory": widget.selectedCategory,
      //"rollNo" : rollNo,
      "supervisor_name" : widget.supervisorName,
      "supervisor_mobileno" : widget.supervisorMobileNo,
      "isolation_address": widget.isolationAddress,
      "isolation_date": widget.isolationDate.toString(),
      "symptoms": widget.symptoms,
      "have_covid": "yes",
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
      _checkLoggedIn.setVisitingFlag(true);
      _checkLoggedIn.setIfAnsweredBeforeFlag(true);
      valueFromBack=true;
    }
    print("puData in general covid data sender");
    print(" == token : {$token}");
    msg = responseBody["message"];
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

  final keys = ['Isolation Address', 'Isolation Date', "Supervisor's name", "Supervisor's Mobile No.",
  "Symptoms"];

  List<String> values ;

  @override
  void initState() {
    super.initState();

    print(widget.selectedCategory);
      print(widget.isolationAddress);
      print(widget.isolationDate);
      print(widget.supervisorName);
      print(widget.supervisorMobileNo);
      print(widget.symptoms);
    values = [widget.isolationAddress, widget.isolationDate.toString(), widget.supervisorName, widget.supervisorMobileNo, widget.symptoms];
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
        //margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
           CustomAppBar(),
            SizedBox(
              height: 50.0,
            ),
            Container(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Data Entered by You\n',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: kWeirdBlue,
                      ),
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: keys.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shadowColor: kWeirdBlue,
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListTile(
                              title: Text(keys[index]),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  values[index],
                                ),
                              ),
                              //isThreeLine: true,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
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
                  if(value==true)
                    {
                      _checkLoggedIn.setIfAnsweredBeforeFlag(true);
                      AlertBox(
                          context: context,
                          alertContent:
                          'Thank you For giving time to fill out the details.',
                          alertTitle: 'Thank you for your cooperation ',
                          rightActionText: 'Close',
                          leftActionText: '',
                          onPressingRightActionButton: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => MonitoringQuestionsTransitionScreen(
                                    selectedCategory: widget.selectedCategory,
                                    id: widget.id,
                                    rollNo: rollNo,
                                  )
                              ),
                                  (route) => false,
                            );
                          }).showAlert();
                    }
                  else
                    {
                      _checkLoggedIn.setIfAnsweredBeforeFlag(false);
                      AlertBox(
                          context: context,
                          alertContent:
                          'The given details were not registered due to some error. Kindly Renter',
                          alertTitle: 'Entry Error !!',
                          rightActionText: 'Close',
                          leftActionText: '',
                          onPressingRightActionButton: () {
                            Navigator.pushNamedAndRemoveUntil(context, '/generalCovidQuestions', (route) => false);
                          }).showAlert();
                    }

                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
