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
import '../ui/views/create_favorite_place/create_favorite_place_view.dart';
import '../ui/views/favorite_places/favorite_places_view.dart';
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
  static const String createFavoritePlaceView = '/create-favorite-place-view';
  static const String favoritePlacesView = '/favorite-places-view';
  static const all = <String>{
    startupView,
    applicationSettingsView,
    authenticationChoiceView,
    signinView,
    accountTypeChoiceView,
    signupView,
    homeView,
    createFavoritePlaceView,
    favoritePlacesView,
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
    RouteDef(Routes.createFavoritePlaceView, page: CreateFavoritePlaceView),
    RouteDef(Routes.favoritePlacesView, page: FavoritePlacesView),
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
      var args = data.getArgs<HomeViewArguments>(
        orElse: () => HomeViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(
          key: args.key,
          viewIndex: args.viewIndex,
        ),
        settings: data,
      );
    },
    CreateFavoritePlaceView: (data) {
      var args = data.getArgs<CreateFavoritePlaceViewArguments>(
        orElse: () => CreateFavoritePlaceViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateFavoritePlaceView(key: args.key),
        settings: data,
      );
    },
    FavoritePlacesView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const FavoritePlacesView(),
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

/// HomeView arguments holder class
class HomeViewArguments {
  final Key? key;
  final int? viewIndex;
  HomeViewArguments({this.key, this.viewIndex});
}

/// CreateFavoritePlaceView arguments holder class
class CreateFavoritePlaceViewArguments {
  final Key? key;
  CreateFavoritePlaceViewArguments({this.key});
}
