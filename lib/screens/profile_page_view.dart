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
      initialValue: parentMobileNo,
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
    title: 'Roll/EC Number',
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

  String rollNo;
  String msg ='';
  String tStudentRollNo;
  String tName;
  String tMobileNo;
  String tHall;
  String tParentName ;
  String tParentMbNo ;
  String tDOB ;
  String tOpd ;


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


  Future getData() async {
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


    if (response.statusCode == 200) {
      valueFromBack = true;
      tName = responseBody["name"];
      tMobileNo = responseBody["phone"];
      tHall = responseBody["hall"];
      tParentName =responseBody["status"];
      tParentMbNo = responseBody["parent_mobileno"];
      tDOB = responseBody["dateofbirth"];
      tOpd = responseBody["opdno"];
    }
    else {
      valueFromBack = false;
    }
    print("getData on profile page");
    print(" == token : {$token}");
    msg = decoded["message"];
    print(" == msg : {$msg}");
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
    bool value = await getData();
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
          value = await getData();
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
        });
      }
    }
    else
    {
      setState(() {
        _loading = false;
      });
    }
    if(value==true)
      {
        setState(() {
          name = tName;
          //rollNo = tStudentRollNo;
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
      }
    else
      {
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
      }
  }

  @override
  void initState() {
    super.initState();
    checkFromBackend();
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
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: kWeirdBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
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
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
