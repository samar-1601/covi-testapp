import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/birthday_widget.dart';
import 'package:coviapp/general_data_and_otp.dart';
import 'package:coviapp/shared_pref.dart';

class StudentChosen extends StatefulWidget {
  final String chosenCategory;
  StudentChosen({this.chosenCategory});

  @override
  _StudentChosenState createState() => _StudentChosenState();
}

class _StudentChosenState extends State<StudentChosen> {



  final formKey = GlobalKey<FormState>();
  String name = '';
  String hall = '';
  String roomNo = '';
  String mobileNo1 = '';
  String mobileNo2 = '';
  String rollNo = '';
  String parentName = '';
  String parentMobileNo = '';
  String emailID = '';
  String password = '';

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
  Widget buildRollNo() => buildTitle(
    title: 'Roll No',
    child: TextFormField(
      initialValue: rollNo,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Your Roll No',
      ),
      onChanged: (rollNo) => setState(() => this.rollNo = rollNo),
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
  Widget buildParentName() => buildTitle(
    title: 'Parent/Guardian Name',
    child: TextFormField(
      initialValue: parentName,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Parent/Guardian Name',
      ),
      onChanged: (parentName) => setState(() => this.parentName = parentName),
    ),
  );
  Widget buildParentMobile() => buildTitle(
    title: 'Parent Contact No',
    child: TextFormField(
      initialValue: name,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Parent Contact No',
      ),
      onChanged: (parentMobileNo) => setState(() => this.parentMobileNo = parentMobileNo),
    ),
  );
  Widget buildHall() => buildTitle(
    title: 'Hall of Residence',
    child: TextFormField(
      initialValue: hall,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Your Hall of Residence',
      ),
      onChanged: (hall) => setState(() => this.hall = hall),
    ),
  );
  Widget buildRoom() => buildTitle(
    title: 'Room No',
    child: TextFormField(
      initialValue: roomNo,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Your Room No',
      ),
      onChanged: (roomNo) => setState(() => this.roomNo = roomNo),
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

  Widget buildBirthday() => buildTitle(
    title: 'Date Of Birth',
    child: BirthdayWidget(
      birthday: birthday,
      onChangedBirthday: (birthday) =>
          setState(() => this.birthday = birthday),
    ),
  );

  // Widget buildPassword() => buildTitle(
  //   title: 'Choose your account password',
  //   child: TextFormField(
  //     initialValue: password,
  //     obscureText: true,
  //     decoration: InputDecoration(
  //       border: OutlineInputBorder(),
  //       hintText: 'Enter your password',
  //     ),
  //     onChanged: (data) => setState(() => this.password= data),
  //   ),
  // );


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


  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();
  bool valueFromBack;
  int id ;
  String studentRollNo;
  Future getID() async
  {
    id = await _checkLoggedIn.getLoginIdValue();
    studentRollNo = await _checkLoggedIn.getRollNo();
  }

  @override
  void initState() {
    super.initState();
    buildBirthday();
    getID();
    buildName();
    buildRollNo();
    buildHall();
    buildRoom();
    buildMobile1();
    buildMobile2();
    buildParentName();
    buildParentMobile();
    buildEmail();
    //buildPassword();
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
                    const SizedBox(height: 20),
                    buildName(),
                    const SizedBox(height: 12),
                    buildRollNo(),
                    // const SizedBox(height: 12),
                    // buildEmail(),
                    const SizedBox(height: 12),
                    buildMobile1(),
                    // const SizedBox(height: 12),
                    // buildMobile2(),
                    const SizedBox(height: 12),
                    buildHall(),
                    const SizedBox(height: 12),
                    buildBirthday(),
                    const SizedBox(height: 12),
                    buildParentName(),
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
                    if(parentMobileNo.length != 10 || mobileNo1.length !=10 || name.length ==0)
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
                                hall: hall,
                                //room: roomNo,
                                selectedCategory: widget.chosenCategory,
                                parentMobileNo: parentMobileNo,
                                parentName: parentName,
                                mobileNo1: mobileNo1,
                               // mobileNo2: mobileNo2,
                                rollNo: studentRollNo,
                                //email: emailID,
                                password: password,
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
