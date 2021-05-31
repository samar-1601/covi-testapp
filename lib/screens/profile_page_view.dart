import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:http/http.dart' as http;
import 'package:coviapp/shared_pref.dart';
import 'package:coviapp/utilities/customAppBar.dart';

class ProfilePageView extends StatefulWidget {

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {



  final formKey = GlobalKey<FormState>();
  String name = '';
  String hall = '';
  String mobileNo1 = '';
  String parentName = '';
  String parentMobileNo = '';
  String password = '';
  String opdNo = '';
  String birthday;


  Widget buildName() => buildTitle(
    title: 'Name',
    child: TextFormField(
      initialValue: name,
      enabled: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: name,
      ),
      onChanged: (name) => setState(() => this.name = name),
    ),
  );

  Widget buildMobile1() => buildTitle(
    title: 'Mobile number ',
    child: TextFormField(
      initialValue: mobileNo1,
      enabled: false,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: mobileNo1,
      ),
      onChanged: (mobileNo1) => setState(() => this.mobileNo1 = mobileNo1),
    ),
  );

  Widget buildParentName() => buildTitle(
    title: 'Parent/Guardian Name',
    child: TextFormField(
      initialValue: parentName,
      enabled: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: parentName,
      ),
      onChanged: (parentName) => setState(() => this.parentName = parentName),
    ),
  );
  Widget buildParentMobile() => buildTitle(
    title: 'Parent Contact No',
    child: TextFormField(
      initialValue: name,
      enabled: false,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: parentMobileNo,
      ),
      onChanged: (parentMobileNo) => setState(() => this.parentMobileNo = parentMobileNo),
    ),
  );
  Widget buildHall() => buildTitle(
    title: 'Hall of Residence',
    child: TextFormField(
      initialValue: hall,
      enabled: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hall,
      ),
      onChanged: (hall) => setState(() => this.hall = hall),
    ),
  );

  Widget buildOPDNo() => buildTitle(
    title: 'OPD Number',
    child: TextFormField(
      initialValue: opdNo,
      enabled: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: opdNo,
      ),
      onChanged: (opdNo) => setState(() => this.opdNo = opdNo),
    ),
  );


  Widget buildBirthday() => buildTitle(
    title: 'Date of Birth',
    child: TextFormField(
      initialValue: birthday,
      enabled: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: birthday,
      ),
      onChanged: (birthday) => setState(() => this.birthday = birthday),
    ),
  );

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
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      );


  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();
  bool valueFromBack;
  bool _loading=false;
  String rollNo;
  String msg ='';


  String token;
  Future getToken() async
  {
    var tempToken= await _checkLoggedIn.getLoginToken();
    setState(() {
      token = tempToken;
    });
  }

  Future getData() async {
    setState(() {
      _loading=true;
    });
    await getToken();
    var url = Uri.parse('https://imedixbcr.iitkgp.ac.in/api/coviapp/get-patient-detail');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final decoded = jsonDecode(response.body) as Map;
    Map responseBody = decoded["data"] as Map;


    String tStudentRollNo =responseBody["status"];
    String tName = responseBody["name"];
    String tMobileNo = responseBody["phone"];
    String tHall = responseBody["hall"];
    String tParentName =responseBody["status"];
    String tParentMbNo = responseBody["parent_mobileno"];
    String tDOB = responseBody["dateofbirth"];
    String tOpd = responseBody["opdno"];

    if (response.statusCode == 200) {
      valueFromBack = true;
      setState(() {
        name = tName;
        rollNo = tStudentRollNo;
        mobileNo1 = tMobileNo;
        hall = tHall;
        parentName = tParentName;
        parentMobileNo = tParentMbNo;
        birthday = tDOB;
        valueFromBack = true;
        opdNo = tOpd;
        buildBirthday();
        buildName();
        buildHall();
        buildMobile1();
        buildParentName();
        buildParentMobile();
        buildOPDNo();
      });
    } else {

      valueFromBack = false;
      AlertBox(
        context: context,
        alertContent:
        'Server Error. Please try again after sometime',
        alertTitle: 'Server Error !!',
        rightActionText: 'Close',
        leftActionText: ' ',
        onPressingRightActionButton: () {
          Navigator.pushNamedAndRemoveUntil(context, '/monitoringQuestionsTransition', (route) => false);
          _checkLoggedIn.setVisitingFlag(false);
        },
      ).showAlert();
    }
    setState(() {
      _loading=false;
    });
  }


  @override
  void initState() {
    super.initState();
    getData();
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
                        'Here are your Profile Details',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildName(),
                  const SizedBox(height: 12),
                  buildMobile1(),
                  // const SizedBox(height: 12),
                  // buildMobile2(),
                  const SizedBox(height: 12),
                  buildHall(),
                  const SizedBox(height: 12),
                  buildBirthday(),
                  const SizedBox(height: 12),
                  buildOPDNo(),
                  const SizedBox(height: 12),
                  buildParentMobile(),
                  // const SizedBox(height: 12),
                  // buildPassword(),
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
                  margin: EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.8,
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
                        'Change Password',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
