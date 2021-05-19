import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/screens/do_you_have_covid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coviapp/shared_pref.dart';

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
      this.email = 'NE'});

  @override
  _GeneralDataSenderState createState() => _GeneralDataSenderState();
}

class _GeneralDataSenderState extends State<GeneralDataSender> {
  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();
  bool valueFromBack;
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
      "rollNo" : " ",
      "parentName" : " ",
      "parentMobileNo": "",
      "email": " ",
    };
    String body = json.encode(data);
    print(body);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      _checkLoggedIn.setVisitingFlag(true);
    } else {
      _checkLoggedIn.setVisitingFlag(false);
    }
    setState(() {
      valueFromBack = _checkLoggedIn.getVisitingFlag();
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.selectedCategory);

    if (widget.selectedCategory == 'Student') {
      print(widget.name);
      print(widget.rollNo);
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
        body: CircularProgressIndicator(
        backgroundColor: Colors.white,
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
                    height: 120.0,
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
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DoYouHaveCovid(
                                      selectedCategory: widget.selectedCategory,
                                    )));
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
