import 'package:coviapp/screens/faculty_chosen.dart';
import 'package:coviapp/screens/monitoring_questions_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/screens/student_chosen.dart';
import 'package:coviapp/screens/miscellaneous_chosen.dart';
import 'package:coviapp/screens/staff_chosen.dart';
import 'package:coviapp/shared_pref.dart';

class ChooseCategory extends StatefulWidget {
  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {

  static List<String> categoryList = [
      'Student',
      'Staff',
      'Faculty',
      'Miscellaneous',
  ];
  void printValue() {
    print(selectedCategory);
  }

  String selectedCategory = categoryList[0];
  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 120.0,
            ),
            Container(
                child: Center(
                  child: Text(
                    'Choose Category',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: kWeirdBlue,
                      width: 1.5,
                    )
                ),
                padding: EdgeInsets.only(
                    top: 5.0, bottom: 5.0, left: 10, right: 10.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: categoryList.length,
                  itemBuilder: (ctx, index) {
                    return RadioListTile<String>(
                      title: Text(
                          categoryList[index],
                          style: TextStyle(
                            color: Colors.black
                          ),
                      ),
                      value: categoryList[index],
                      groupValue: selectedCategory,
                      activeColor: kWeirdBlue,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                          printValue();
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            GestureDetector(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: kWeirdBlue,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
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
                bool alreadyAnswered = await _checkLoggedIn.getIfAnsweredBeforeFlag();
                setState(() {
                  if(selectedCategory == 'Student')
                    {
                      if(alreadyAnswered==true)
                        {
                          _checkLoggedIn.setVisitingFlag(true);
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              MonitoringQuestionsTransitionScreen(
                                selectedCategory: selectedCategory,
                              )
                          ), (Route<dynamic> route) => false);
                        }
                      else{
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    StudentChosen(chosenCategory: selectedCategory,)
                            )
                        );
                      }
                    }
                  else if(selectedCategory == 'Staff')
                  {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                StaffChosen(chosenCategory: selectedCategory,)
                        )
                    );
                  }
                  else if(selectedCategory == 'Faculty')
                  {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                FacultyChosen(chosenCategory: selectedCategory,)
                        )
                    );
                  }
                  else if(selectedCategory == 'Miscellaneous')
                  {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MiscChosen(chosenCategory: selectedCategory,)
                        )
                    );
                  }
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
