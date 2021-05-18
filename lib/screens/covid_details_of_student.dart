import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/customDropDownButton.dart';
//import 'package:coviapp/general_data.dart';

class CovidQuestionsForStudents extends StatefulWidget {
  final String chosenCategory;
  CovidQuestionsForStudents({this.chosenCategory});

  @override
  _CovidQuestionsForStudentsState createState() => _CovidQuestionsForStudentsState();
}

class _CovidQuestionsForStudentsState extends State<CovidQuestionsForStudents> {


  List<DropdownMenuItem> getDropDownItems(List dropDownList) {
    List<DropdownMenuItem> dropDownItems = [];
    for (int i = 1; i < dropDownList.length; i++) {
      String listItem = dropDownList[i];
      var newItem = DropdownMenuItem(
        child: Text(listItem),
        value: listItem,
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  Widget makeOptions(List<String> answers, int index, Map<String,List<String>> mp)
  {
    return Column(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
               mp.keys.toList()[index],
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
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
                buttonHintText: "Select your Choice",
                items: getDropDownItems(mp[mp.keys.toList()[index]]),
                value: answers[index],
                onTap: (value) {
                  setState(() {
                    answers[index] = value;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  List<Widget> listGenerator(Map<String,List<String>> mp, List<String> answers)
  {
    List<Widget> listItems = [];

    for(int i=0; i<answers.length; i++)
      {
        listItems.add(makeOptions(answers, i, mp));
      }
    return listItems;
  }

    List<String> regularQuesList = [
      'Does you family know about you being COVID +VE?',
      'Do you have access to thermometer?',
      'Do you have arrangements to heat water for drinking, preparing tea etc.?' ,
      'Do you have access to steamer (for inhaling steam if needed)?' ,
      'Can you arrange Pulse-Oximeter, if needed?' ,
      'Do you know contact details of food suppliers for you?',
      'How do you get required (extra) items from market?' ,
      'Do you have contact information for getting medical attention, if needed?' ,
      'Do you have your laptop/mobile in working condition?' ,
    ];
  List<List<String>> regularQuesOptionsList = [
    doParentsKnow,
    haveThermometer,
    waterArrangements,
    haveSteamer,
    haveOximeter,
    haveFoodSupplierContact,
    howGetExtraItems,
    haveContactForMedicalAttention,
    haveWorkingLaptop,
  ];

  List<String> wellBeingQuesList = [
    'Do you have fever?',
    'Do you feel body ache?',
    'Do you have dry cough?' ,
    'Do you have soar throat?',
    'Do you have difficulty in eating?' ,
    'Have you lost sense of smell?',
    'Have you lost sense of taste?',
    'Do you feel anxiety or difficulty in sleeping?',
    'Please tell how do you assess your current health' ,
    'Are you talking with family and friends daily?',
  ];
  List<List<String>> wellBeingQuesOptionsList = [
    haveFever,
    haveBodyAche,
    haveDryCough,
    haveSoreThroat,
    haveEatingDifficulty,
    haveLostSmell,
    haveLostTaste,
    haveSleepingAnxiety,
    assessCurrentHealth,
    talkingWithFriends,
  ];
  static Map<String,List<String>> regularQuestionsMap = {};
  static Map<String,List<String>> wellBeingQuestionsMap = {};

  void initializeRegularQuestions()
  {
      for(int i=0; i<regularQuesList.length; i++)
        {
          setState(() {
            regularQuestionsMap[regularQuesList[i]] = regularQuesOptionsList[i];
          });

        }
  }
  void initializeWellBeingQuestions()
  {
    for(int i=0; i<wellBeingQuesList.length; i++)
    {
      setState(() {
        wellBeingQuestionsMap[wellBeingQuesList[i]] = wellBeingQuesOptionsList[i];
      });

    }
  }


  static List<String> doParentsKnow = [null, 'Yes', 'No'];

  String doParentsKnowInput = doParentsKnow[0];

  String haveThermometerInput = haveThermometer[0];
  static List<String> haveThermometer = [
    null,
    'Yes',
    'No',
  ];
  String waterArrangementsInput = waterArrangements[0];
  static List<String> waterArrangements = [
    null,
    'Yes',
    'No',
  ];
  String steamerAccessInput = haveSteamer[0];
  static List<String> haveSteamer = [
    null,
    'Yes',
    'No',
  ];
  String haveOximeterInput = haveOximeter[0];
  static List<String> haveOximeter = [
    null,
    'Yes',
    'No',
    'Maybe',
    'Available with me',
  ];
  String haveFoodSupplierContactInput = haveFoodSupplierContact[0];
  static List<String> haveFoodSupplierContact = [
    null,
    'Yes',
    'No',
  ];

  String howGetExtraItemsInput = howGetExtraItems[0];
  static List<String> howGetExtraItems = [
    null,
    'Through Friends',
    'Through Vendors',
    'Through Task Force',
    'None',
  ];

  String haveContactForMedicalAttentionInput = haveContactForMedicalAttention[0];
  static List<String> haveContactForMedicalAttention = [
    null,
    'Yes',
    'No',
  ];
  String haveWorkingLaptopInput = haveWorkingLaptop[0];
  static List<String> haveWorkingLaptop = [
    null,
    'Yes',
    'No',
  ];

  String haveFeverInput = haveFever[0];
  static List<String> haveFever = [
    null,
    'Very High (above 102 F)',
    'High (between 100 - 102 F)',
    'Moderate (99 - 100 F)',
    'Low (98.6 - 99 F)',
    'None'
  ];

  String haveBodyAcheInput = haveBodyAche[0];
  static List<String> haveBodyAche = [
    null,
    'Yes',
    'No',
  ];

  String haveDryCoughInput = haveDryCough[0];
  static List<String> haveDryCough = [
    null,
    'Yes',
    'No',
  ];
  String haveSoreThroatInput = haveSoreThroat[0];
  static List<String> haveSoreThroat = [
    null,
    'Yes',
    'No',
  ];
  String haveEatingDifficultyInput = haveEatingDifficulty[0];
  static List<String> haveEatingDifficulty = [
    null,
    'Yes',
    'No',
  ];
  String haveLostSmellInput = haveLostSmell[0];
  static List<String> haveLostSmell = [
    null,
    'Yes',
    'No',
  ];
  String haveLostTasteInput = haveLostTaste[0];
  static List<String> haveLostTaste = [
    null,
    'Yes',
    'No',
  ];
  String haveSleepingAnxietyInput = haveSleepingAnxiety[0];
  static List<String> haveSleepingAnxiety = [
    null,
    'Yes',
    'No',
  ];
  String talkingWithFriendsInput = talkingWithFriends[0];
  static List<String> talkingWithFriends = [
    null,
    'Yes',
    'No',
  ];
  String assessCurrentHealthInput = assessCurrentHealth[0];
  static List<String> assessCurrentHealth = [
    null,
    'Yes',
    'No',
  ];

void printValues(List<String> answers)
{
  print("----------------- Answers Values ------------------\n");
  for(int i=0; i<answers.length ; i++)
    {
      print(answers[i]);
    }
  print("----------------- Answers Values End ------------------\n");
}
  List<String> regularQuesAnswersList = [], wellBeingQuesAnswersList=[];
  @override
  void initState() {
    super.initState();
    regularQuesAnswersList = [
      doParentsKnowInput,
      haveThermometerInput,
      waterArrangementsInput,
      steamerAccessInput,
      haveOximeterInput,
      haveFoodSupplierContactInput,
      howGetExtraItemsInput,
      haveContactForMedicalAttentionInput,
      haveWorkingLaptopInput,
    ];
    wellBeingQuesAnswersList=[
      haveFeverInput,
      haveBodyAcheInput,
      haveDryCoughInput,
      haveSoreThroatInput,
      haveEatingDifficultyInput,
      haveLostSmellInput,
      haveLostTasteInput,
      haveSleepingAnxietyInput,
      assessCurrentHealthInput,
      talkingWithFriendsInput,
    ];

    initializeRegularQuestions();
    initializeWellBeingQuestions();
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
                          'Don\'t worry, you will get well soon. Please enter the following details so that we can help you out',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: kWeirdBlue,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child: SingleChildScrollView(
                          child: Column(
                              children:
                                listGenerator(regularQuestionsMap, regularQuesAnswersList),
                            ),
                        ),
                        ),
                      ),
                    Container(
                      child: Center(
                        child: Text(
                          'Questions on Well-Being',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: kWeirdBlue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children:
                            listGenerator(wellBeingQuestionsMap, wellBeingQuesAnswersList),
                          ),
                        ),
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
                onTap: () {
                  printValues(regularQuesAnswersList);
                  printValues(wellBeingQuesAnswersList);
                  // setState(() {
                  //
                  //   // Navigator.push( =commented now==
                  //   //     context,
                  //   //     new MaterialPageRoute(
                  //   //         builder: (BuildContext context) => DietPlanScreen2(
                  //   //           regionInput: regionInput,
                  //   //           vegnonvegInput: vegnonvegInput,
                  //   //           trimesterInput: trimesterInput,
                  //   //           chosenCategory: widget.chosenCategory,
                  //   //         )));
                  // });
                },
              )
            ],
        ),
      ),
    );
  }
}


//Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Does you family know about you being COVID Positive ?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(doParentsKnow),
//                                         value: doParentsKnowInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             doParentsKnowInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================have Thermometer============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Do you have access to thermometer?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveThermometer),
//                                         value: haveThermometerInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             haveThermometerInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Do you have arrangements to heat water for drinking, preparing tea etc.?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Do you have arrangements to heat water for drinking, preparing tea etc. ?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(waterArrangements),
//                                         value: waterArrangementsInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             waterArrangementsInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Do you have access to steamer (for inhaling steam if needed)?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Do you have access to steamer (for inhaling steam if needed)?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveSteamer),
//                                         value: steamerAccessInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             steamerAccessInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Can you arrange Pulse-Oximeter, if needed?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Can you arrange Pulse-Oximeter, if needed?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveOximeter),
//                                         value: haveOximeterInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             haveOximeterInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Do you know contact details of food suppliers for you?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Do you know contact details of food suppliers for you?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveFoodSupplierContact),
//                                         value: haveFoodSupplierContactInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             haveFoodSupplierContactInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================How do you get required (extra) items from market?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'How do you get required (extra) items from market?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(howGetExtraItems),
//                                         value: howGetExtraItemsInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             howGetExtraItemsInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Do you have contact information for getting medical attention, if needed?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Do you have contact information for getting medical attention, if needed?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveContactForMedicalAttention),
//                                         value: haveContactForMedicalAttentionInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             haveContactForMedicalAttentionInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Do you have your laptop/mobile in working condition?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Do you have your laptop/mobile in working condition?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveWorkingLaptop),
//                                         value: haveWorkingLaptopInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             haveWorkingLaptopInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Questions on Well-Being============
//                                 Container(
//                                   child: Center(
//                                     child: Text(
//                                       'Questions on Well-Being',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         fontSize: 22.0,
//                                         fontWeight: FontWeight.bold,
//                                         color: kWeirdBlue,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Have -Fever?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Do you have fever?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveFever),
//                                         value: haveFeverInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             haveFeverInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================haveBodyAcheInput============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Do you feel body ache?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveBodyAche),
//                                         value: haveBodyAcheInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             haveBodyAcheInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Do you have dry cough?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Do you have dry cough?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveDryCough),
//                                         value: haveDryCoughInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             haveDryCoughInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Do you have sore throat?===========
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Do you have sore throat?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveSoreThroat),
//                                         value: haveSoreThroatInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             haveSoreThroatInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //===================Do you have difficulty in eating?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Do you have difficulty in eating?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveEatingDifficulty),
//                                         value: haveEatingDifficultyInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             haveEatingDifficultyInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Have you lost sense of smell?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Have you lost sense of smell?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveLostSmell),
//                                         value: haveLostSmellInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             haveLostSmellInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Have you lost sense of taste?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Have you lost sense of taste?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveLostTaste),
//                                         value: haveLostTasteInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             haveLostTasteInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Do you feel anxiety or difficulty in sleeping?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Do you feel anxiety or difficulty in sleeping?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(haveSleepingAnxiety),
//                                         value: haveSleepingAnxietyInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             haveSleepingAnxietyInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Please tell how do you assess your current health============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Please tell how do you assess your current health',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(assessCurrentHealth),
//                                         value: assessCurrentHealthInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             assessCurrentHealthInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),
//                                 //====================Are you talking with family and friends daily?============
//                                 Column(
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         'Are you talking with family and friends daily?',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.only(bottom: 16.0, right: 20.0),
//                                       width: MediaQuery.of(context).size.width * 1,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10.0),
//                                           border: Border.all(
//                                             color: kWeirdBlue,
//                                             width: 1.5,
//                                           )),
//                                       child: CustomDropDownButton(
//                                         hintTextColor: Colors.black,
//                                         dropDownColor: Colors.white,
//                                         dropDownItemColor: Colors.black,
//                                         buttonHintText: 'Yes/No',
//                                         items: getDropDownItems(talkingWithFriends),
//                                         value: talkingWithFriendsInput,
//                                         onTap: (value) {
//                                           setState(() {
//                                             talkingWithFriendsInput = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 30.0,
//                                 ),