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

  setLoginToken(String value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", value);
  }

  getLoginToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token")??"";
    return token;
  }

  setPasswordToken(String value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("password", value);
  }

  getPasswordToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String password = preferences.getString("password")??"";
    return password;
  }
//--------------------- Login details storage ---------------------------

  //name
  setNameToken(String value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name", value);
  }

  getNameToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String name = preferences.getString("name")??"";
    return name;
  }

  // roll no
  setRollNoToken(String value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("rollNo", value);
  }

  getRollNoToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String rollNo = preferences.getString("rollNo")??"";
    return rollNo;
  }

  // Mobile Number
  setMbNoToken(String value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("mbNo", value);
  }

  getMbNoToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String mbNo = preferences.getString("mbNo")??"";
    return mbNo;
  }

  // Hall of residence
  setHallToken(String value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("hall", value);
  }

  getHallToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String hall = preferences.getString("hall")??"";
    return hall;
  }

  setParentNameToken(String value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("parentName", value);
  }

  getParentNameToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String parentName = preferences.getString("parentName")??"";
    return parentName;
  }

  setParentMbNoToken(String value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("parentMbNo", value);
  }

  getParentMbNoToken() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String parentMbNo = preferences.getString("parentMbNo")??"";
    return parentMbNo;
  }
}