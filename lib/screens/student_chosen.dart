import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/birthday_widget.dart';
import 'package:coviapp/general_data_and_otp.dart';
import 'package:coviapp/shared_pref.dart';
import 'package:coviapp/utilities/customAppBar.dart';
import 'package:coviapp/utilities/customDropDownButton.dart';
import 'package:intl/intl.dart';

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
  String isVaccinated = '';

  String password = '';

  DateTime birthday;
  DateTime firstDose;
  DateTime secondDose;

  static List<String> categoryList = [
    'Select Vaccine Name',
    'Covishield',
    'Covaxin',
  ];
  String vaccineName =categoryList[0];

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
    title: 'Mobile number ',
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
      initialValue: parentMobileNo,
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

  Widget buildHaveYouBeenVaccinated() => buildTitle(
    title: 'Have you been Vaccinated? (Yes/No)',
    child: TextFormField(
      initialValue: isVaccinated,
      //keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Vaccinated?(Yes/No)',
      ),
      onChanged: (emailID) => setState(() => this.isVaccinated = emailID),
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

  Widget buildDateForDose1() => buildTitle(
    title: 'Date of Vaccination (First Dose)',
    child: BirthdayWidget(
      birthday: firstDose,
      hinText: 'Enter Date',
      onChangedBirthday: (birthday) =>
          setState(() => this.firstDose = birthday),
    ),
  );

  Widget buildDateForDose2() => buildTitle(
    title: 'Date of Vaccination (Second Dose if taken)',
    child: BirthdayWidget(
      birthday: secondDose,
      hinText: 'Enter Date',
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


  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();
  bool valueFromBack;
  int id ;
  String studentRollNo;

  void printValue() {
    print(vaccineName);
  }
  bool isNumeric(String s) {
    if (s == "") {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  void initState() {
    super.initState();
    buildBirthday();
    //getID();
    buildName();
    buildRollNo();
    buildHall();
    buildRoom();
    buildMobile1();
    buildMobile2();
    buildParentName();
    buildParentMobile();
    buildHaveYouBeenVaccinated();
    //buildPassword();
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
                          'Enter your details',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: kWeirdBlue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // buildName(),
                    // const SizedBox(height: 12),
                    // buildRollNo(),
                    // const SizedBox(height: 12),
                    // buildEmail(),
                    // const SizedBox(height: 12),
                    // buildMobile1(),
                    // const SizedBox(height: 12),
                    // buildMobile2(),
                    const SizedBox(height: 12),
                    buildHall(),
                    // const SizedBox(height: 12),
                    // buildBirthday(),
                    // const SizedBox(height: 12),
                    // buildParentName(),
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
                        buttonHintText: "Name of vaccine",
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
                height: 30.0,
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
                    bool isNum = isNumeric(parentMobileNo);
                    print("isNum = $isNum");
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
                      if(isVaccinated.toLowerCase()=='yes' && (vaccineName=='Select Vaccine Name' || firstDose==null))
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
                          if(isVaccinated.toLowerCase()=='yes')
                            {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) => GeneralDataSender(
                                        name: name,
                                        hall: hall,
                                        selectedCategory: widget.chosenCategory,
                                        parentMobileNo: parentMobileNo,
                                        rollNo: rollNo,
                                        isVaccinated: isVaccinated,
                                        vaccineName: vaccineName=='Select Vaccine Name'?'Not applicable':vaccineName,
                                        firstDose: firstDose==null?'First Dose not taken':DateFormat('dd-MM-yyyy').format(firstDose).toString(),
                                        secondDose: secondDose==null?'Second Dose not taken':DateFormat('dd-MM-yyyy').format(secondDose).toString(),
                                      )));
                            }
                          else
                            {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) => GeneralDataSender(
                                        name: name,
                                        hall: hall,
                                        selectedCategory: widget.chosenCategory,
                                        parentMobileNo: parentMobileNo,
                                        rollNo: rollNo,
                                        isVaccinated: isVaccinated,
                                        vaccineName: 'Not applicable',
                                        firstDose:'First Dose not taken',
                                        secondDose: 'Second Dose not taken',
                                      )));
                            }

                        }

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
