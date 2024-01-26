import 'package:cgpa_application/presentation/cgpa_screen/homePage.dart';
import 'package:flutter/material.dart';
import 'package:cgpa_application/presentation/adacana_screen/adacana_screen.dart';
import 'package:cgpa_application/presentation/login_or_signup_screen/login_or_signup_screen.dart';
import 'package:cgpa_application/presentation/signup_screen/signup_screen.dart';
import 'package:cgpa_application/presentation/login_screen/login_screen.dart';
import 'package:cgpa_application/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String adacanaScreen = '/adacana_screen';

  static const String loginOrSignupScreen = '/login_or_signup_screen';

  static const String signupScreen = '/signup_screen';

  static const String loginScreen = '/login_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String cgpaScreen = '/cgpa_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    adacanaScreen: (context) => AdacanaScreen(),
    loginOrSignupScreen: (context) => LoginOrSignupScreen(),
    signupScreen: (context) => SignupScreen(),
    loginScreen: (context) => LoginScreen(),
    cgpaScreen: (context) => MyHomePage(),
    appNavigationScreen: (context) => CustomNavBar()
  };
}
