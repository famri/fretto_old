// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../ui/views/account_type_choice/account_type_choice_view.dart';
import '../ui/views/application_settings/application_settings_view.dart';
import '../ui/views/authentication_choice/authentication_choice_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/signin/signin_view.dart';
import '../ui/views/signup/signup_view.dart';
import '../ui/views/startup/startup_view.dart';

class Routes {
  static const String startupView = '/';
  static const String applicationSettingsView = '/application-settings-view';
  static const String authenticationChoiceView = '/authentication-choice-view';
  static const String signinView = '/signin-view';
  static const String accountTypeChoiceView = '/account-type-choice-view';
  static const String signupView = '/signup-view';
  static const String homeView = '/home-view';
  static const all = <String>{
    startupView,
    applicationSettingsView,
    authenticationChoiceView,
    signinView,
    accountTypeChoiceView,
    signupView,
    homeView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.applicationSettingsView, page: ApplicationSettingsView),
    RouteDef(Routes.authenticationChoiceView, page: AuthenticationChoiceView),
    RouteDef(Routes.signinView, page: SigninView),
    RouteDef(Routes.accountTypeChoiceView, page: AccountTypeChoiceView),
    RouteDef(Routes.signupView, page: SignupView),
    RouteDef(Routes.homeView, page: HomeView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartupView(),
        settings: data,
      );
    },
    ApplicationSettingsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ApplicationSettingsView(),
        settings: data,
      );
    },
    AuthenticationChoiceView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AuthenticationChoiceView(),
        settings: data,
      );
    },
    SigninView: (data) {
      var args = data.getArgs<SigninViewArguments>(
        orElse: () => SigninViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SigninView(key: args.key),
        settings: data,
      );
    },
    AccountTypeChoiceView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AccountTypeChoiceView(),
        settings: data,
      );
    },
    SignupView: (data) {
      var args = data.getArgs<SignupViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignupView(
          key: args.key,
          isTransporter: args.isTransporter,
        ),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SigninView arguments holder class
class SigninViewArguments {
  final Key? key;
  SigninViewArguments({this.key});
}

/// SignupView arguments holder class
class SignupViewArguments {
  final Key? key;
  final bool isTransporter;
  SignupViewArguments({this.key, required this.isTransporter});
}
