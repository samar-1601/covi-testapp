import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coviapp/utilities/alert_box.dart';
import 'package:coviapp/utilities/constants.dart';
import 'package:coviapp/shared_pref.dart';
import 'package:coviapp/screens/monitoring_questions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:coviapp/utilities/customAppBar.dart';

class MonitoringQuestionsTransitionScreen extends StatefulWidget {
  final String selectedCategory;
  final String name;
  final String hall;
  final String room;
  final DateTime birthday;
  final String mobileNo1;
  final String mobileNo2;
  final String rollNo ;
  final String parentName ;
  final String parentMobileNo ;
  final int id ;

  MonitoringQuestionsTransitionScreen(
      {this.id,this.selectedCategory,this.name, this.hall, this.room, this.birthday,
        this.rollNo, this.mobileNo1, this.mobileNo2, this.parentName, this.parentMobileNo});

  @override
  _MonitoringQuestionsTransitionScreenState createState() => _MonitoringQuestionsTransitionScreenState();
}

class _MonitoringQuestionsTransitionScreenState extends State<MonitoringQuestionsTransitionScreen> {

  CheckLoggedIn _checkLoggedIn = CheckLoggedIn();
  bool valueFromBack;
  int id ;
  String rollNo;
Future getID() async
{
  id = await _checkLoggedIn.getLoginIdValue();
  rollNo = await _checkLoggedIn.getRollNo();
}
  Future<void> _launched;
  String _phone = "7061436275";
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  void initState() {
    super.initState();
    getID();
    print(widget.selectedCategory);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
           CustomAppBar(),
            SizedBox(
              height: 150.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text(
                  'Please Answer the required questions so that we can monitor you',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: kWeirdBlue,
                  ),
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
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => MonitoringQuestions(
                            rollNo: rollNo,
                          )));
                });
              },
            ),
            SizedBox(
              height: 100.0,
            ),
            GestureDetector(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.red,
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
                        'LogOut',
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
                  AlertBox(
                      context: context,
                      alertContent:
                      'Do you want to Logout?',
                      alertTitle: 'Logout?',
                      rightActionText: 'Yes',
                      leftActionText: 'No',
                      onPressingLeftActionButton: (){
                        Navigator.pop(context);
                      },
                      onPressingRightActionButton: () {
                        _checkLoggedIn.setVisitingFlag(false);
                        _checkLoggedIn.setLoginIdValue(0);
                        _checkLoggedIn.setIfAnsweredBeforeFlag(false);
                        _checkLoggedIn.setRollNo("Your RollNo");
                        _checkLoggedIn.setNameToken(" Your Name");
                        _checkLoggedIn.setParentMbNoToken("Parent's Contact Number");
                        _checkLoggedIn.setParentNameToken("Parent's Name");
                        _checkLoggedIn.setMbNoToken("Your Mobile Number");
                        _checkLoggedIn.setHallToken("Your Hall of Residence");
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
                      }).showAlert();
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
              heroTag: "profile",
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              onPressed: () {
               Navigator.pushNamed(context, '/profileView');
              }
          ),
          FloatingActionButton.extended(
              label: Text('SOS'),
              heroTag: "sos",
              icon: Icon(
                Icons.call,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () async{
                setState(() {
                  _makePhoneCall('tel:$_phone');
                });
              }
          ),
        ],
      )
    );
  }
}
