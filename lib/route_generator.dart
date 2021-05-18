import 'package:flutter/material.dart';
import 'package:coviapp/screens/icon_screen.dart';
import 'package:coviapp/screens/welcome_screen.dart';
import 'package:coviapp/screens/choose_category.dart';
import 'package:coviapp/screens/student_chosen.dart';
import 'package:coviapp/screens/faculty_chosen.dart';
import 'package:coviapp/screens/staff_chosen.dart';
import 'package:coviapp/screens/miscellaneous_chosen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => IconScreen(),
        );
      case '/welcome':
        return MaterialPageRoute(
          builder: (_) => WelcomeScreen(),
        );
      case '/chooseCategory':
        return MaterialPageRoute(
          builder: (_) => ChooseCategory(),
        );
      case '/studentChosen':
        return MaterialPageRoute(
          builder: (_) => StudentChosen(),
        );
      case '/facultyChosen':
        return MaterialPageRoute(
          builder: (_) => FacultyChosen(),
        );
      case '/staffChosen':
        return MaterialPageRoute(
          builder: (_) => StaffChosen(),
        );
      case '/miscChosen':
        return MaterialPageRoute(
          builder: (_) => MiscChosen(),
        );
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
