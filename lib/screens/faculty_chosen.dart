import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/birthday_widget.dart';
import 'package:coviapp/general_data.dart';



//import 'package:coviapp/screens/diet_plan_screen_2.dart';

class FacultyChosen extends StatefulWidget {
  final String chosenCategory;
  FacultyChosen({this.chosenCategory});

  @override
  _FacultyChosenState createState() => _FacultyChosenState();
}

class _FacultyChosenState extends State<FacultyChosen> {



  final formKey = GlobalKey<FormState>();
  String name = '';
  String hall = '';
  String mobileNo1 = '';
  String mobileNo2 = '';
  String ecNo = '';
  String emailID ='';
  DateTime birthday;


  Widget buildName() => buildTitle(
    title: 'Name',
    child: TextFormField(
      initialValue: name,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Your Name',
      ),
      onChanged: (name) => setState(() => this.name = name),
    ),
  );
  Widget buildAddress() => buildTitle(
    title: 'Enter Address',
    child: TextFormField(
      initialValue: hall,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Your Address',
      ),
      onChanged: (hall) => setState(() => this.hall = hall),
    ),
  );

  Widget buildEcNo() => buildTitle(
    title: 'EC Number',
    child: TextFormField(
      initialValue: ecNo,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter EC Number',
      ),
      onChanged: (eclNo) => setState(() => this.ecNo = ecNo),
    ),
  );
  Widget buildMobile1() => buildTitle(
    title: 'Mobile number 1',
    child: TextFormField(
      initialValue: mobileNo1,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Primary mobile No',
      ),
      onChanged: (mobileNo1) => setState(() => this.mobileNo1 = mobileNo1),
    ),
  );
  Widget buildMobile2() => buildTitle(
    title: 'Mobile number 2',
    child: TextFormField(
      initialValue: mobileNo2,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Secondary mobile No',
      ),
      onChanged: (mobileNo2) => setState(() => this.mobileNo2 = mobileNo2),
    ),
  );

  Widget buildBirthday() => buildTitle(
    title: 'Date of Birth',
    child: BirthdayWidget(
      birthday: birthday,
      onChangedBirthday: (birthday) =>
          setState(() => this.birthday = birthday),
    ),
  );
  Widget buildEmail() => buildTitle(
    title: 'Email ID',
    child: TextFormField(
      initialValue: emailID,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Frequently used mail ID',
      ),
      onChanged: (emailID) => setState(() => this.emailID = emailID),
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
  @override
  void initState() {
    super.initState();

    buildBirthday();
    buildName();
    buildAddress();
    buildMobile1();
    buildMobile2();
    buildEcNo();
    buildEmail();
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
                  buildName(),
                  const SizedBox(height: 12),
                  buildEcNo(),
                  const SizedBox(height: 12),
                  buildEmail(),
                  const SizedBox(height: 12),
                  buildMobile1(),
                  const SizedBox(height: 12),
                  buildMobile2(),
                  const SizedBox(height: 12),
                  buildAddress(),
                  const SizedBox(height: 12),
                  buildBirthday(),

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
              onTap: () {
                setState(() {
                  if(mobileNo1.length !=10 || name.length ==0)
                  {
                    AlertBox(
                        context: context,
                        alertContent:
                        'Please Enter valid Name/Phone No',
                        alertTitle: 'Invalid Entry !!',
                        rightActionText: 'Close',
                        leftActionText: '',
                        onPressingRightActionButton: () {
                          Navigator.pop(context);
                        }).showAlert();
                  }
                  else
                    {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => GeneralDataSender(
                                name: name,
                                birthday: birthday,
                                rollNo: ecNo,
                                hall: hall,
                                selectedCategory: widget.chosenCategory,
                                mobileNo1: mobileNo1,
                                mobileNo2: mobileNo2,
                                email: emailID,
                              )));
                    }

                });
              },
            )
          ],
        ),
      ),
    );
  }
}
