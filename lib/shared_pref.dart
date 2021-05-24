import 'package:shared_preferences/shared_preferences.dart';

class CheckLoggedIn {

  bool loggedIn = false;
  setVisitingFlag(bool value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("alreadyVisited", value);
  }

  getVisitingFlag() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool alreadyVisited = preferences.getBool("alreadyVisited")??false;
    return alreadyVisited;
  }

  setRollNo(String value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("RollNo", value);
  }

  getRollNo() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String rollNo = preferences.getString("RollNo")??"";
    return rollNo;
  }

  setIfAnsweredBeforeFlag(bool value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("alreadyAnswered", value);
  }

  getIfAnsweredBeforeFlag() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool alreadyAnswered = preferences.getBool("alreadyAnswered")??false;
    return alreadyAnswered;
  }
  setLoginIdValue(int value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("LoginID", value);
  }

  getLoginIdValue() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int loginID = preferences.getInt("LoginID")??0;
    return loginID;
  }

}