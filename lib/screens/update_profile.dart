import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/birthday_widget.dart';
import 'package:http/http.dart' as http;
import 'package:coviapp/shared_pref.dart';
import 'package:coviapp/utilities/customAppBar.dart';
import 'package:coviapp/utilities/customDropDownButton.dart';
import 'package:intl/intl.dart';
import 'profile_page_view.dart';


class UpdateProfile extends StatefulWidget {
  final String chosenCategory;
  final String hall;
  final String rollNo;
  final String parentMobileNo;
  final String isVaccinated;
  final String vaccineName;

  final String firstDose;
  final String secondDose;

  UpdateProfile(
      {
        this.chosenCategory,
        this.secondDose,
        this.isVaccinated,
        this.rollNo,
        this.firstDose,
        this.vaccineName,
        this.hall,
        this.parentMobileNo,
      });

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  final formKey = GlobalKey<FormState>();

  String parentMobileNo = '';
  String isVaccinated = '';
  String hall ='';

  DateTime firstDose;
  DateTime secondDose;

  static List<String> categoryList = [
    'Select Vaccine Name',
    'Covishield',
    'Covaxin',
  ];
  String vaccineName ='';


  Widget buildParentMobile() => buildTitle(
    title: 'Parent Contact No',
    child: TextFormField(
      initialValue: widget.parentMobileNo,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: widget.parentMobileNo,
      ),
      onChanged: (parentMobileNo) => setState(() => this.parentMobileNo = parentMobileNo),
    ),
  );

  Widget buildHaveYouBeenVaccinated() => buildTitle(
    title: 'Have you been Vaccinated? (Yes/No)',
    child: TextFormField(
      initialValue: widget.isVaccinated,
      //keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: widget.isVaccinated,
      ),
      onChanged: (value) => setState(() => this.isVaccinated = value),
    ),
  );

  Widget buildDateForDose1() => buildTitle(
    title: 'Date of Vaccination (First Dose)',
    child: BirthdayWidget(
      birthday: firstDose,
      hinText:  widget.firstDose==null?'First Dose not taken':widget.firstDose,
      onChangedBirthday: (birthday) =>
          setState(() => this.firstDose = birthday),
    ),
  );

  Widget buildDateForDose2() => buildTitle(
    title: 'Date of Vaccination (Second Dose if taken)',
    child: BirthdayWidget(
      birthday: secondDose,
      hinText: widget.secondDose==null?'Second Dose not taken':widget.secondDose,
      onChangedBirthday: (birthday) =>
          setState(() => this.secondDose = birthday),
    ),
  );

  List<DropdownMenuItem> getDropDownItems(List dropDownList) {
    List<DropdownMenuItem> dropDownItems = [];
    for (int i = 0; i < dropDownList.length; i++) {
      String listItem = dropDownList[i];
      var newItem = DropdownMenuItem(
        child: Text(listItem),
        value: listItem,
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
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
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
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

  void printValue() {
    print(vaccineName);
  }
  bool isNumeric(String s) {
    if (s == "") {
      return false;
    }
    return double.tryParse(s) != null;
  }

  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();
  bool valueFromBack;
  String rollNo;
  String msg='';

  Future putData(String parentMobileNo, String isVaccinated, String vaccineName, String firstDose, String secondDose) async {
    var url = Uri.parse('https://imedixbcr.iitkgp.ac.in/api/coviapp/update-patient-detail');
    Map data = {};
    if(isVaccinated.toLowerCase()=='yes')
      {
        data = {
          "hall": widget.hall,
          "parent_mobileno": parentMobileNo,
          "selected_category": widget.chosenCategory,
          "vaccinated": isVaccinated,
          "vaccine_type": vaccineName,
          "date_of_first_dose": firstDose,
          "date_of_second_dose": secondDose==null?'':secondDose,
        };
      }
    else if(isVaccinated.toLowerCase()=='no')
      {
        data = {
          "hall": widget.hall,
          "parent_mobileno": parentMobileNo,
          "selected_category": widget.chosenCategory,
          "vaccinated": isVaccinated,
          "vaccine_type": "",
          "date_of_first_dose": "",
          "date_of_second_dose": "",
        };
      }

    String body = json.encode(data);
    print(body);
    var response = await http.post(url,
      headers: {"Content-Type": "application/json",'Authorization': 'Bearer $token',}, body: body,);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Map responseBody = json.decode(response.body) as Map;
    String status = responseBody['status'];
    if (response.statusCode != 200 ||  status!='success') {
      _checkLoggedIn.setVisitingFlag(false);
      _checkLoggedIn.setIfAnsweredBeforeFlag(false);
    }
    else {
      _checkLoggedIn.setVisitingFlag(true);
    }
    print("puData in update profile");
    valueFromBack = await _checkLoggedIn.getVisitingFlag();
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
    });
    await getID();
    await getToken();
    bool value = await putData(parentMobileNo,
        isVaccinated,
        vaccineName,
        firstDose==null?widget.firstDose:DateFormat('dd-MM-yyyy').format(firstDose).toString(),
        secondDose==null?widget.secondDose:DateFormat('dd-MM-yyyy').format(secondDose).toString(),
    );
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
          value = await  putData(parentMobileNo,
            isVaccinated,
            vaccineName,
            firstDose==null?widget.firstDose:DateFormat('dd-MM-yyyy').format(firstDose).toString(),
            firstDose==null?widget.secondDose:DateFormat('dd-MM-yyyy').format(secondDose).toString(),
          );
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
    buildParentMobile();
    buildHaveYouBeenVaccinated();
    buildDateForDose1();
    buildDateForDose2();
    parentMobileNo = widget.parentMobileNo;
    vaccineName = widget.vaccineName;
    isVaccinated = widget.isVaccinated;
    hall = widget.hall;
    vaccineName = widget.vaccineName==''?'Select Vaccine Name':widget.vaccineName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            CustomAppBar(),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Text(
                        'Update details',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: kWeirdBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const SizedBox(height: 12),
                  buildParentMobile(),
                  const SizedBox(height: 12),
                  buildHaveYouBeenVaccinated(),
                  const SizedBox(height: 25),
                  Center(
                    child: Text(
                      'Fill in the below details if you have been vaccinated. If not, you can later update it in the profile page after successfully logging into the Coviapp.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: kWeirdBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  buildDateForDose1(),
                  const SizedBox(height: 12),
                  buildDateForDose2(),
                  const SizedBox(height: 16),
                  Text(
                    'Select the vaccine you have taken',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: kWeirdBlue,
                          width: 1.5,
                        )),
                    child: CustomDropDownButton(
                      hintTextColor: Colors.black,
                      dropDownColor: Colors.white,
                      dropDownItemColor: Colors.black,
                      buttonHintText: vaccineName,
                      items: getDropDownItems(categoryList),
                      value: vaccineName,
                      onTap: (value) {
                        setState(() {
                          vaccineName = value;
                          //value = vaccineName;
                        });
                      },
                    ),
                  ),
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
                        'Confirm Update',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              onTap: () async{
                bool isNum = false;

                setState((){
                  isNum = isNumeric(parentMobileNo);
                  print("isNum = $isNum");
                });
                  if(parentMobileNo.length != 10 || isNum==false)
                  {
                    AlertBox(
                        context: context,
                        alertContent:
                        'Please Enter valid Phone No',
                        alertTitle: 'Invalid Entry !!',
                        rightActionText: 'Close',
                        leftActionText: '',
                        onPressingRightActionButton: () {
                          Navigator.pop(context);
                        }).showAlert();
                  }
                  else if(isVaccinated.toLowerCase()=='')
                  {
                    AlertBox(
                        context: context,
                        alertContent:
                        'Please Enter the Vaccinated status',
                        alertTitle: 'Mandatory field not entered !!',
                        rightActionText: 'Close',
                        leftActionText: '',
                        onPressingRightActionButton: () {
                          Navigator.pop(context);
                        }).showAlert();
                  }
                  else if(isVaccinated.toLowerCase()=='no' && (firstDose!=null||secondDose!=null))
                  {
                    AlertBox(
                        context: context,
                        alertContent:
                        'You cannot enter vaccination date, if you are not vaccinated !',
                        alertTitle: 'Invalid Entry !!',
                        rightActionText: 'Close',
                        leftActionText: '',
                        onPressingRightActionButton: () {
                          Navigator.pop(context);
                        }).showAlert();
                  }
                  else
                  {
                    if(isVaccinated.toLowerCase()=='yes' && (vaccineName=='Select Vaccine Name'||vaccineName=='Not Applicable'||vaccineName=='' || (firstDose==null && widget.firstDose=='')))
                    {
                      AlertBox(
                          context: context,
                          alertContent:
                          'Please enter Vaccination Date and Vaccine Name',
                          alertTitle: 'Invalid Entry !!',
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
                              'Details have been Updated successfully!',
                              alertTitle: 'ThankYou',
                              rightActionText: 'Close',
                              leftActionText: '',
                              onPressingRightActionButton: () {
                                Navigator.of(context).pop();
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
                  }
              },
            ),
            SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }
}
