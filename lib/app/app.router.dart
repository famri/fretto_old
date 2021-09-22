// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../models/client_journey_request_dto.dart';
import '../models/interlocutor.dart';
import '../ui/views/account_type_choice/account_type_choice_view.dart';
import '../ui/views/application_settings/application_settings_view.dart';
import '../ui/views/authentication_choice/authentication_choice_view.dart';
import '../ui/views/create_favorite_place/create_favorite_place_view.dart';
import '../ui/views/discussions/discussions_view.dart';
import '../ui/views/favorite_places/favorite_places_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/journey_creation/journey_creation_view.dart';
import '../ui/views/journey_details/journey_details_view.dart';
import '../ui/views/journey_proposals/journey_proposals_view.dart';
import '../ui/views/messaging/messaging_view.dart';
import '../ui/views/mobile_number_check/mobile_number_check_view.dart';
import '../ui/views/mobile_validation_sms_code/mobile_validation_sms_code_view.dart';
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
  static const String mobileNumberCheckView = '/mobile-number-check-view';
  static const String mobileValidationSMSCodeView =
      '/mobile-validation-sm-scode-view';
  static const String journeyCreationView = '/journey-creation-view';
  static const String journeyDetailsView = '/journey-details-view';
  static const String journeyProposalsView = '/journey-proposals-view';
  static const String discussionsView = '/discussions-view';
  static const String messagingView = '/messaging-view';
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
    mobileNumberCheckView,
    mobileValidationSMSCodeView,
    journeyCreationView,
    journeyDetailsView,
    journeyProposalsView,
    discussionsView,
    messagingView,
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
    RouteDef(Routes.mobileNumberCheckView, page: MobileNumberCheckView),
    RouteDef(Routes.mobileValidationSMSCodeView,
        page: MobileValidationSMSCodeView),
    RouteDef(Routes.journeyCreationView, page: JourneyCreationView),
    RouteDef(Routes.journeyDetailsView, page: JourneyDetailsView),
    RouteDef(Routes.journeyProposalsView, page: JourneyProposalsView),
    RouteDef(Routes.discussionsView, page: DiscussionsView),
    RouteDef(Routes.messagingView, page: MessagingView),
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
    MobileNumberCheckView: (data) {
      var args = data.getArgs<MobileNumberCheckViewArguments>(
        orElse: () => MobileNumberCheckViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => MobileNumberCheckView(key: args.key),
        settings: data,
      );
    },
    MobileValidationSMSCodeView: (data) {
      var args =
          data.getArgs<MobileValidationSMSCodeViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => MobileValidationSMSCodeView(
          key: args.key,
          icc: args.icc,
          mobileNumber: args.mobileNumber,
        ),
        settings: data,
      );
    },
    JourneyCreationView: (data) {
      var args = data.getArgs<JourneyCreationViewArguments>(
        orElse: () => JourneyCreationViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => JourneyCreationView(
          key: args.key,
          journeyRequest: args.journeyRequest,
        ),
        settings: data,
      );
    },
    JourneyDetailsView: (data) {
      var args = data.getArgs<JourneyDetailsViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => JourneyDetailsView(
          key: args.key,
          journeyRequest: args.journeyRequest,
        ),
        settings: data,
      );
    },
    JourneyProposalsView: (data) {
      var args = data.getArgs<JourneyProposalsViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => JourneyProposalsView(
          key: args.key,
          journeyId: args.journeyId,
        ),
        settings: data,
      );
    },
    DiscussionsView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DiscussionsView(),
        settings: data,
      );
    },
    MessagingView: (data) {
      var args = data.getArgs<MessagingViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => MessagingView(
          key: args.key,
          interlocutor: args.interlocutor,
          discussionId: args.discussionId,
        ),
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

/// MobileNumberCheckView arguments holder class
class MobileNumberCheckViewArguments {
  final Key? key;
  MobileNumberCheckViewArguments({this.key});
}

/// MobileValidationSMSCodeView arguments holder class
class MobileValidationSMSCodeViewArguments {
  final Key? key;
  final String icc;
  final String mobileNumber;
  MobileValidationSMSCodeViewArguments(
      {this.key, required this.icc, required this.mobileNumber});
}

/// JourneyCreationView arguments holder class
class JourneyCreationViewArguments {
  final Key? key;
  final ClientJourneyRequestDto? journeyRequest;
  JourneyCreationViewArguments({this.key, this.journeyRequest});
}

/// JourneyDetailsView arguments holder class
class JourneyDetailsViewArguments {
  final Key? key;
  final ClientJourneyRequestDto journeyRequest;
  JourneyDetailsViewArguments({this.key, required this.journeyRequest});
}

/// JourneyProposalsView arguments holder class
class JourneyProposalsViewArguments {
  final Key? key;
  final int journeyId;
  JourneyProposalsViewArguments({this.key, required this.journeyId});
}

/// MessagingView arguments holder class
class MessagingViewArguments {
  final Key? key;
  final Interlocutor interlocutor;
  final int discussionId;
  MessagingViewArguments(
      {this.key, required this.interlocutor, required this.discussionId});
}
