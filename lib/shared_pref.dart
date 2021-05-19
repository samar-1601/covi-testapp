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
}