import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/utilities/birthday_widget.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/customDropDownButton.dart';
import 'package:coviapp/screens/covid_data_sender.dart';


class CovidQuestions extends StatefulWidget {
  final String chosenCategory;
  final int id;
  CovidQuestions({this.id,this.chosenCategory});

  @override
  _CovidQuestionsState createState() => _CovidQuestionsState();
}

class _CovidQuestionsState extends State<CovidQuestions> {


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
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
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

    List<String> areYouEquippedQuesList = [
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
  List<List<String>> areYouEquippedQuesOptionsList = [
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
    'Do you have sore throat?',
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
  static Map<String,List<String>> areYouEquippedQuestionsMap = {};
  static Map<String,List<String>> wellBeingQuestionsMap = {};

  void initializeAreYouEquippedQuestions()
  {
      for(int i=0; i<areYouEquippedQuesList.length; i++)
        {
          setState(() {
            areYouEquippedQuestionsMap[areYouEquippedQuesList[i]] = areYouEquippedQuesOptionsList[i];
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

  final formKey = GlobalKey<FormState>();
  String isolationAddress = '';
  String supervisorName = '';
  String dsaCouncilMemberName1 = '';
  String dsaCouncilMemberName2 = '';
  String dsaCouncilMember1MbNo = '';
  String dsaCouncilMember2MbNo = '';
  String supervisorMobileNo = '';
  String seekHelp = '';
  String suggestions = '';

  DateTime isolationDate;


  Widget buildIsolationAdd() => buildTitle(
    title: 'Current Isolation Address',
    child: TextFormField(
      initialValue: isolationAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Current isolation address',
      ),
      onChanged: (data) => setState(() => this.isolationAddress = data),
    ),
  );
  Widget buildSuperVisorName() => buildTitle(
    title: 'Name of Supervisor',
    child: TextFormField(
      initialValue: supervisorName,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Name',
      ),
      onChanged: (data) => setState(() => this.supervisorName = data),
    ),
  );
  Widget buildDsaCouncilMem1Name() => buildTitle(
    title: 'Name of Dean SA Council Member - 1 in contact ',
    child: TextFormField(
      initialValue: dsaCouncilMemberName1,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Name',
      ),
      onChanged: (data) => setState(() => this.dsaCouncilMemberName1 = data),
    ),
  );
  Widget buildDsaCouncilMem2Name() => buildTitle(
    title: 'Name of Dean SA Council Member - 2 in contact ',
    child: TextFormField(
      initialValue: dsaCouncilMemberName2,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Name',
      ),
      onChanged: (data) => setState(() => this.dsaCouncilMemberName2 = data),
    ),
  );

  Widget buildSeekHelp() => buildTitle(
    title: 'What help do you seek?',
    child: TextFormField(
      initialValue: seekHelp,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Write your problems',
      ),
      onChanged: (data) => setState(() => this.seekHelp = data),
    ),
  );

  Widget buildSuggestions() => buildTitle(
    title: 'Additional Comments and Suggestions',
    child: TextFormField(
      initialValue: suggestions,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter your suggestions',
      ),
      onChanged: (data) => setState(() => this.suggestions = data),
    ),
  );
  Widget buildSupervisorMbNo() => buildTitle(
    title: 'SuperVisor Mobile No',
    child: TextFormField(
      initialValue: supervisorMobileNo,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'SuperVisor Mobile No',
      ),
      onChanged: (mobileNo) => setState(() => this.supervisorMobileNo = mobileNo),
    ),
  );
  Widget buildDsaCouncilMem1Mb() => buildTitle(
    title: 'Dean SA Council Member-1 Mobile No',
    child: TextFormField(
      initialValue: dsaCouncilMember1MbNo,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Mobile No',
      ),
      onChanged: (mobileNo) => setState(() => this.dsaCouncilMember1MbNo = mobileNo),
    ),
  );
  Widget buildDsaCouncilMem2Mb() => buildTitle(
    title: 'Dean SA Council Member-1 Mobile No',
    child: TextFormField(
      initialValue: dsaCouncilMember2MbNo,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Mobile No',
      ),
      onChanged: (mobileNo) => setState(() => this.dsaCouncilMember2MbNo = mobileNo),
    ),
  );
  Widget buildIsolationDate() => buildTitle(
    title: 'Date when found positive and started isolation?',
    child: BirthdayWidget(
      birthday: isolationDate,
      hinText: 'Enter Date',
      onChangedBirthday: (birthday) =>
          setState(() => this.isolationDate = birthday),
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

void printValues(List<String> answers)
{
  print("----------------- Answers Values ------------------\n");
  for(int i=0; i<answers.length ; i++)
    {
      print(answers[i]);
    }
  print([isolationAddress,supervisorName,dsaCouncilMemberName1,dsaCouncilMemberName2,dsaCouncilMember1MbNo,dsaCouncilMember2MbNo,supervisorMobileNo,seekHelp,suggestions,isolationDate]);
  print("----------------- Answers Values End ------------------\n");
}


  List<String> areYouEquippedQuesAnswersList = [], wellBeingQuesAnswersList=[];
  @override
  void initState() {
    super.initState();
    areYouEquippedQuesAnswersList = [
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

    initializeAreYouEquippedQuestions();
    initializeWellBeingQuestions();
    buildIsolationDate();
    buildIsolationAdd();
    buildSuperVisorName();
    buildSupervisorMbNo();
    buildDsaCouncilMem1Mb();
    buildDsaCouncilMem1Name();
    buildDsaCouncilMem2Name();
    buildDsaCouncilMem2Mb();
    buildSeekHelp();
    buildSuggestions();
  }

  //==========================================setting already answered shared Preference===============
 // CheckLoggedIn _checkLoggedIn = CheckLoggedIn();


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
                    const SizedBox(height: 32),
                    buildIsolationAdd(),
                    const SizedBox(height: 12),
                    buildIsolationDate(),
                    const SizedBox(height: 12),
                    buildSuperVisorName(),
                    const SizedBox(height: 12),
                    buildSupervisorMbNo(),
                    const SizedBox(height: 12),
                    buildDsaCouncilMem1Name(),
                    const SizedBox(height: 12),
                    buildDsaCouncilMem1Mb(),
                    const SizedBox(height: 12),
                    buildDsaCouncilMem2Name(),
                    const SizedBox(height: 12),
                    buildDsaCouncilMem2Mb(),
                    const SizedBox(height: 30),
                    Container(
                      child: Center(
                        child: Text(
                          'Are You Equipped ?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.0,
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
                                listGenerator(areYouEquippedQuestionsMap, areYouEquippedQuesAnswersList),
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
                    const SizedBox(height: 12),
                    buildSeekHelp(),
                    const SizedBox(height: 12),
                    buildSuggestions(),
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
                  printValues(areYouEquippedQuesAnswersList);
                  printValues(wellBeingQuesAnswersList);

                  setState(() {

                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => CovidDataSender(
                              areYouEquippedQuestions: areYouEquippedQuesList,
                              areYouEquippedAnswers: areYouEquippedQuesAnswersList,
                              wellBeingQuestions: wellBeingQuesList,
                              wellBeingAnswers: wellBeingQuesAnswersList,
                              id: widget.id,
                            )));
                  });
                },
              )
            ],
        ),
      ),
    );
  }
}

