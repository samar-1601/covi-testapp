import 'package:flutter/material.dart';
import 'package:coviapp/screens/icon_screen.dart';
import 'package:coviapp/screens/welcome_screen.dart';
import 'package:coviapp/screens/choose_category.dart';
import 'package:coviapp/screens/student_chosen.dart';
import 'package:coviapp/screens/faculty_chosen.dart';
import 'package:coviapp/screens/staff_chosen.dart';
import 'package:coviapp/screens/login_screen.dart';
import 'package:coviapp/screens/choose_sign_up_login_screen.dart';
import 'package:coviapp/screens/miscellaneous_chosen.dart';
import 'package:coviapp/screens/do_you_have_covid.dart';
import 'package:coviapp/screens/general_covid_questions.dart';
import 'package:coviapp/screens/monitoring_questions_transition.dart';
import 'package:coviapp/screens/monitoring_questions.dart';
import 'package:coviapp/screens/profile_page_view.dart';

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
      case '/signup':
        return MaterialPageRoute(
          builder: (_) => ChooseSignUpLoginScreen(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case '/doYouHaveCovid':
        return MaterialPageRoute(
          builder: (_) => DoYouHaveCovid(),
        );
      case '/generalCovidQuestions':
        return MaterialPageRoute(
          builder: (_) => CovidQuestions(),
        );
      case '/monitoringQuestions':
        return MaterialPageRoute(
          builder: (_) => MonitoringQuestions(),
        );
      case '/monitoringQuestionsTransition':
        return MaterialPageRoute(
          builder: (_) => MonitoringQuestionsTransitionScreen(),
        );
      case '/profileView':
        return MaterialPageRoute(
          builder: (_) => ProfilePageView(),
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
