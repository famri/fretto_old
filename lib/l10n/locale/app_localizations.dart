import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        (locale.countryCode == null || locale.countryCode!.isEmpty)
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get saveButtonText {
    return Intl.message(
      'SAVE',
      name: 'saveButtonText',
      desc: 'Save button text',
    );
  }

  String get publishButtonText {
    return Intl.message(
      'PUBLISH',
      name: 'publishButtonText',
      desc: 'Publish button text',
    );
  }

  String get deleteButtonText {
    return Intl.message(
      'DELETE',
      name: 'deleteButtonText',
      desc: 'Delete button text',
    );
  }

  String get updateButtonText {
    return Intl.message(
      'UPDATE',
      name: 'updateButtonText',
      desc: 'Update button text',
    );
  }

  String get editButtonText {
    return Intl.message(
      'EDIT',
      name: 'editButtonText',
      desc: 'Edit button text',
    );
  }

  String get nextButtonText {
    return Intl.message(
      'SUIVANT',
      name: 'nextButtonText',
      desc: 'Next button text',
    );
  }

  String get resetButtonText {
    return Intl.message(
      'RESET',
      name: 'resetButtonText',
      desc: 'Reset button text',
    );
  }

  String get clearTooltipText {
    return Intl.message(
      'Clear',
      name: 'clearTooltipText',
      desc: 'Clear tooltip text',
    );
  }

  String get doneTooltipText {
    return Intl.message(
      'Done',
      name: 'doneTooltipText',
      desc: 'Done tooltip text',
    );
  }

  String get newTooltipText {
    return Intl.message(
      'New',
      name: 'newTooltipText',
      desc: 'New tooltip text',
    );
  }

  String get closeTooltipText {
    return Intl.message(
      'Close',
      name: 'closeTooltipText',
      desc: 'Close tooltip text',
    );
  }

  String get applicationSettingsAppBarTitle {
    return Intl.message(
      'APPLICATION SETTINGS',
      name: 'applicationSettingsAppBarTitle',
      desc: 'Application settings app bar title',
    );
  }

  String get applicationSettingsCountryText {
    return Intl.message(
      'Country:',
      name: 'applicationSettingsCountryText',
      desc: 'Application settings country text',
    );
  }

  String get applicationSettingsLanguageText {
    return Intl.message(
      'Language:',
      name: 'applicationSettingsLanguageText',
      desc: 'Application settings language text',
    );
  }

  String get applicationSettingsTimeZoneText {
    return Intl.message(
      'Time zone:',
      name: 'applicationSettingsTimeZoneText',
      desc: 'Application settings time zone text',
    );
  }

  String get addFavoriteLocationAppBarTitle {
    return Intl.message(
      'ADD A PLACE',
      name: 'addFavoriteLocationAppBarTitle',
      desc: 'App bar title',
    );
  }

  String get addFavoriteLocationPlaceNameLabel {
    return Intl.message(
      'Name',
      name: 'addFavoriteLocationPlaceNameLabel',
      desc: 'Place name inputText label',
    );
  }

  String get addFavoriteLocationAlertTitle {
    return Intl.message(
      'WARNING!',
      name: 'addFavoriteLocationAlertTitle',
      desc: 'Alert dialog title',
    );
  }

  String get addFavoriteLocationAlertOk {
    return Intl.message(
      'OK',
      name: 'addFavoriteLocationAlertOk',
      desc: 'Ok button text',
    );
  }

  String get addFavoriteLocationMissingPlaceName {
    return Intl.message(
      'Please give a place name before saving.',
      name: 'addFavoriteLocationMissingPlaceName',
      desc: 'Missing place name alert dialog text',
    );
  }

  String get addFavoriteLocationMissingPlaceLocation {
    return Intl.message(
      'Please select a place location before saving.',
      name: 'addFavoriteLocationMissingPlaceLocation',
      desc: 'Missing place name alert dialog text',
    );
  }

  String get addFavoriteLocationChoosePlaceText {
    return Intl.message(
      'Choose a place',
      name: 'addFavoriteLocationChoosePlaceText',
      desc: 'Choose a place text',
    );
  }

  String get addFavoriteLocationMyPositionText {
    return Intl.message(
      'My position',
      name: 'addFavoriteLocationMyPositionText',
      desc: 'My position text',
    );
  }

  String get addFavoriteLocationLocateOnMapText {
    return Intl.message(
      'Locate on map',
      name: 'addFavoriteLocationLocateOnMapText',
      desc: 'Locate on map text',
    );
  }

  String get addFavoriteLocationLocateOnMapAppBarText {
    return Intl.message(
      'LOCATE ON MAP',
      name: 'addFavoriteLocationLocateOnMapAppBarText',
      desc: 'Locate on map text',
    );
  }

  String get authenticationMotto {
    return Intl.message(
      'Finding a carrier has never been easier!',
      name: 'authenticationMotto',
      desc: 'motto of the company',
    );
  }

  String get authenticationSignupText {
    return Intl.message(
      'SIGN UP',
      name: 'authenticationSignupText',
      desc: 'Signup text',
    );
  }

  String get chooseUserTypeAppBarText {
    return Intl.message(
      'TYPE DE COMPTE',
      name: 'chooseUserTypeAppBarText',
      desc: 'Choose user type screen title',
    );
  }

  String get chooseUserTypeHeaderText {
    return Intl.message(
      'Quel type d\'utilisateur êtes vous?',
      name: 'chooseUserTypeHeaderText',
      desc: 'Choose user type header title',
    );
  }

  String get chooseUserTypeTransporterLabel {
    return Intl.message(
      'Transporteur:',
      name: 'chooseUserTypeTransporterLabel',
      desc: 'Choose user type transporter label',
    );
  }

  String get chooseUserTypeCustomerLabel {
    return Intl.message(
      'Client:',
      name: 'chooseUserTypeCustomerLabel',
      desc: 'Choose user type customer label',
    );
  }

  String get chooseUserTypeErrorText {
    return Intl.message(
      'Veuillez sélectionner un type de compte.',
      name: 'chooseUserTypeErrorText',
      desc: 'Choose user type error text',
    );
  }

  String get signUpAppBarTitle {
    return Intl.message(
      'SIGN UP',
      name: 'signUpAppBarTitle',
      desc: 'Sign up screen title',
    );
  }

  String get signUpAppButtonText {
    return Intl.message(
      'SIGN UP',
      name: 'signUpAppButtonText',
      desc: 'Sign up button text',
    );
  }

  String get signUpTOS1 {
    return Intl.message(
      'By signing up, you accept, without reservations, our ',
      name: 'signUpTOS1',
      desc: 'Sign up terms of service part 1 text',
    );
  }

  String get signUpTOS2 {
    return Intl.message(
      'terms of service ',
      name: 'signUpTOS2',
      desc: 'Sign up terms of service part 2 text',
    );
  }

  String get signUpTOS3 {
    return Intl.message(
      'and our ',
      name: 'signUpTOS3',
      desc: 'Sign up terms of service part 3 text',
    );
  }

  String get signUpTOS4 {
    return Intl.message(
      'privacy policy.',
      name: 'signUpTOS4',
      desc: 'Sign up terms of service part 4 text',
    );
  }

  String get signUpAlreadyMemberSignInText {
    return Intl.message(
      'ALREADY MEMBER? SIGN IN',
      name: 'signUpAlreadyMemberSignInText',
      desc: 'Sign up already member sign in text',
    );
  }

  String get signUpGenderLabel {
    return Intl.message(
      'Gender',
      name: 'signUpGenderLabel',
      desc: 'Sign up gender label',
    );
  }

  String get signUpFirstnameLabel {
    return Intl.message(
      'Firstname',
      name: 'signUpFirstnameLabel',
      desc: 'Sign up firstname label',
    );
  }

  String get signUpLastnameLabel {
    return Intl.message(
      'Lastname',
      name: 'signUpLastnameLabel',
      desc: 'Sign up lastname label',
    );
  }

  String get signUpBirthDateLabel {
    return Intl.message(
      'Birth date',
      name: 'signUpBirthDateLabel',
      desc: 'Sign up birth date label',
    );
  }

  String get signUpEmailLabel {
    return Intl.message(
      'E-mail',
      name: 'signUpEmailLabel',
      desc: 'Sign up email label',
    );
  }

  String get signUpMobileNumberLabel {
    return Intl.message(
      'Mobile number',
      name: 'signUpMobileNumberLabel',
      desc: 'Sign up mobile number label',
    );
  }

  String get signUpPasswordLabel {
    return Intl.message(
      'Password (8 characters min)',
      name: 'signUpPasswordLabel',
      desc: 'Sign up password label',
    );
  }

  String get signUpConfirmPasswordLabel {
    return Intl.message(
      'Password confirmation',
      name: 'signUpConfirmPasswordLabel',
      desc: 'Sign up password confirmation label',
    );
  }

  String get signUpFirstnameValidationMessage {
    return Intl.message(
      'Firstname is mandatory.',
      name: 'signUpFirstnameValidationMessage',
      desc: 'Sign up firstname error message',
    );
  }

  String get signUpLastnameValidationMessage {
    return Intl.message(
      'Lastname is mandatory.',
      name: 'signUpLastnameValidationMessage',
      desc: 'Sign up lastname error message',
    );
  }

  String get signUpPasswordValidationMessage {
    return Intl.message(
      'Password does not correspond to confirmation.',
      name: 'signUpPasswordValidationMessage',
      desc: 'Sign up password error message',
    );
  }

  String get signUpSubscribeNewsletterText {
    return Intl.message(
      'Receive promotions and good deals?',
      name: 'signUpSubscribeNewsletterText',
      desc: 'Sign up receive newsletter text',
    );
  }

  String get signUpUnavailableText {
    return Intl.message(
      'Signing up is temporarily unavailable. Please try again later.',
      name: 'signUpUnavailableText',
      desc: 'Sign up unavailable text',
    );
  }

  String get authenticationSigninText {
    return Intl.message(
      'SIGN IN',
      name: 'authenticationSigninText',
      desc: 'Signin text',
    );
  }

  String get authenticationBadCredentialsText {
    return Intl.message(
      'Login or password are incorrect.',
      name: 'authenticationBadCredentialsText',
      desc: 'Bad credentials text',
    );
  }

  String get somethingWentWrongText {
    return Intl.message(
      'An error occured while processing your request. Please contact support team if error persists.',
      name: 'somethingWentWrongText',
      desc: 'something Went Wrong Text',
    );
  }

  String get signInForgottenPasswordText {
    return Intl.message(
      'Forgot password?',
      name: 'signInForgottenPasswordText',
      desc: 'Forgot password text',
    );
  }

  String get signInNotYetMemeberSignUpText {
    return Intl.message(
      'NOT YET MEMBER? -> SIGN UP',
      name: 'signInNotYetMemeberSignUpText',
      desc: 'not yet member text',
    );
  }

  String get signInLoginLabel {
    return Intl.message(
      'E-mail OR Mobile number',
      name: 'signInLoginLabel',
      desc: 'Login label',
    );
  }

  String get signInPasswordLabel {
    return Intl.message(
      'Password',
      name: 'signInPasswordLabel',
      desc: 'Password label',
    );
  }

  String get loginValidatorMessage {
    return Intl.message(
      'E-mail or mobile number is incorrect.',
      name: 'loginValidatorMessage',
      desc: 'login validator message',
    );
  }

  String get emailValidatorMessage {
    return Intl.message(
      'E-mail is incorrect.',
      name: 'emailValidatorMessage',
      desc: 'email validator message',
    );
  }

  String get phoneValidatorMessage {
    return Intl.message(
      'Mobile number is incorrect.',
      name: 'phoneValidatorMessage',
      desc: 'email validator message',
    );
  }

  String get passwordValidatorMessage {
    return Intl.message(
      'Password should contain at least 8 characters.',
      name: 'passwordValidatorMessage',
      desc: 'password validator message',
    );
  }

  String get dateBeforeValidatorMessage {
    return Intl.message(
      'Start date should be before end date.',
      name: 'dateBeforeValidatorMessage',
      desc: 'dateBefore validator message',
    );
  }

  String get ageEmptyValidatorMessage {
    return Intl.message(
      'Birth date is mandatory.',
      name: 'ageEmptyValidatorMessage',
      desc: 'dateBefore validator message',
    );
  }

  String get ageMinValidatorMessage {
    return Intl.message(
      'You should be at least 18 years old.',
      name: 'ageMinValidatorMessage',
      desc: 'age min validator message',
    );
  }

  String get ageMaxValidatorMessage {
    return Intl.message(
      'You should be at most 100 years old.',
      name: 'ageMaxValidatorMessage',
      desc: 'age max validator message',
    );
  }

  String get createJourneyAppBarTitle {
    return Intl.message(
      'JOURNEY REQUEST',
      name: 'createJourneyAppBarTitle',
      desc: 'Journey request screen title',
    );
  }

  String get createJourneyHeaderText {
    return Intl.message(
      'Detail your request:',
      name: 'createJourneyHeaderText',
      desc: 'Journey request header text',
    );
  }

  String get createJourneyDepartureLabel {
    return Intl.message(
      'Departure',
      name: 'createJourneyDepartureLabel',
      desc: 'Journey request departure label text',
    );
  }

  String get createJourneyDepartureValidatorMessage {
    return Intl.message(
      'Departure is mandatory.',
      name: 'createJourneyDepartureValidatorMessage',
      desc: 'Journey request departure validator message',
    );
  }

  String get createJourneyArrivalLabel {
    return Intl.message(
      'Arrival',
      name: 'createJourneyArrivalLabel',
      desc: 'Journey request arrival label text',
    );
  }

  String get createJourneyArrivalValidatorMessage {
    return Intl.message(
      'Arrival is mandatory.',
      name: 'createJourneyArrivalValidatorMessage',
      desc: 'Journey request arrival validator message',
    );
  }

  String get createJourneyVehiculeLabel {
    return Intl.message(
      'Vehicule',
      name: 'createJourneyVehiculeLabel',
      desc: 'Journey request vehicule label text',
    );
  }

  String get createJourneyVehiculeValidatorMessage {
    return Intl.message(
      'Vehicule is mandatory.',
      name: 'createJourneyVehiculeValidatorMessage',
      desc: 'Create journey request vehicule validator message',
    );
  }

  String get createJourneyDateLabel {
    return Intl.message(
      'Date',
      name: 'createJourneyDateLabel',
      desc: 'Journey request date label text',
    );
  }

  String get createJourneyDateValidatorMessage {
    return Intl.message(
      'Date is mandatory.',
      name: 'createJourneyDateValidatorMessage',
      desc: 'Date field validation message',
    );
  }

  String get createJourneyTimeLabel {
    return Intl.message(
      'Time',
      name: 'createJourneyTimeLabel',
      desc: 'Journey request time label text',
    );
  }

  String get createJourneyTimeValidatorMessage {
    return Intl.message(
      'Time is mandatory.',
      name: 'createJourneyTimeValidatorMessage',
      desc: 'Time field validation message',
    );
  }

  String get createJourneyHandlersLabel {
    return Intl.message(
      'Handlers',
      name: 'createJourneyHandlersLabel',
      desc: 'Journey request handlers label text',
    );
  }

  String get createJourneyDescriptionLabel {
    return Intl.message(
      'Describe your request',
      name: 'createJourneyDescriptionLabel',
      desc: 'Journey request description label text',
    );
  }

  String get createJourneyDescriptionValidatorMessage {
    return Intl.message(
      'Description is mandatory.',
      name: 'createJourneyDescriptionValidatorMessage',
      desc: 'Journey request description validator message',
    );
  }

  String get favoritePlacesAppBarTitle {
    return Intl.message(
      'FAVORITE PLACES',
      name: 'favoritePlacesAppBarTitle',
      desc: 'Favorite places app bar title',
    );
  }

  String get favoritePlacesEmptyText {
    return Intl.message(
      'You do not have favorite places yet.',
      name: 'favoritePlacesEmptyText',
      desc: 'Favorite places empty text',
    );
  }

  String get localitySearchHelpText {
    return Intl.message(
      'Type a locality name',
      name: 'localitySearchHelpText',
      desc: 'Locality search help text',
    );
  }

  String get loadingText {
    return Intl.message(
      'Loading...',
      name: 'loadingText',
      desc: 'Loading text',
    );
  }

  String get resetPasswordAppBarTitle {
    return Intl.message(
      'PASSWORD RESET',
      name: 'resetPasswordAppBarTitle',
      desc: 'reset Password AppBar Title',
    );
  }

  String get resetPasswordResultText {
    return Intl.message(
      'If login exists, an E-mail or SMS containing password reset link will be sent to you within 10 minutes.',
      name: 'resetPasswordResultText',
      desc: 'reset Password result text',
    );
  }

  String get validateMobileAlertTitle {
    return Intl.message(
      'Mobile validation required',
      name: 'validateMobileAlertTitle',
      desc: 'validate Mobile Alert Title',
    );
  }

  String get validateMobileAlertText1 {
    return Intl.message(
      'Your mobile number is not yet validated.',
      name: 'validateMobileAlertText1',
      desc: 'validate Mobile Alert Text1',
    );
  }

  String get validateMobileAlertText2 {
    return Intl.message(
      'Please validate it before proceeding.',
      name: 'validateMobileAlertText2',
      desc: 'validate Mobile Alert Text2',
    );
  }

  String get clientJourneysAppBarTitle {
    return Intl.message(
      'MY JOURNEYS',
      name: 'clientJourneysAppBarTitle',
      desc: 'client journeys app bar title',
    );
  }

  String get clientJourneysEmptyText {
    return Intl.message(
      'You have no journey requests for the chosen period.',
      name: 'clientJourneysEmptyText',
      desc: 'client Journeys Empty Text',
    );
  }

  String get clientJourneysSortDateDesc {
    return Intl.message(
      'Latest first',
      name: 'clientJourneysSortDateDesc',
      desc: 'client journeys date sort desc',
    );
  }

  String get clientJourneysSortDateAsc {
    return Intl.message(
      'Oldest first',
      name: 'clientJourneysSortDateAsc',
      desc: 'client journeys date sort asc',
    );
  }

  String get clientJourneysFilterLastWeek {
    return Intl.message(
      'Last week',
      name: 'clientJourneysFilterLastWeek',
      desc: 'client journeys filter created last week',
    );
  }

  String get clientJourneysFilterLastMonth {
    return Intl.message(
      'Last month',
      name: 'clientJourneysFilterLastMonth',
      desc: 'client journeys filter created last month',
    );
  }

  String get clientJourneysFilterLastQuarter {
    return Intl.message(
      'Last quarter',
      name: 'clientJourneysFilterLastQuarter',
      desc: 'client journeys filter created last quarter',
    );
  }

  String get clientJourneysFilterLastSemester {
    return Intl.message(
      'Last semester',
      name: 'clientJourneysFilterLastSemester',
      desc: 'client journeys filter created last semester',
    );
  }

  String get clientJourneysFilterLastYear {
    return Intl.message(
      'Last year',
      name: 'clientJourneysFilterLastYear',
      desc: 'client journeys filter created last year',
    );
  }

  String get clientJourneysInfoTooltip {
    return Intl.message(
      'Details',
      name: 'clientJourneysInfoTooltip',
      desc: 'client Journeys Info Tooltip',
    );
  }

  String get clientJourneysProposalsTooltip {
    return Intl.message(
      'Offers',
      name: 'clientJourneysProposalsTooltip',
      desc: 'client Journeys Proposals Tooltip',
    );
  }

  String get clientJourneysOpened {
    return Intl.message(
      'OPEN',
      name: 'clientJourneysOpened',
      desc: 'client Journeys Opened',
    );
  }

  String get clientJourneysExpired {
    return Intl.message(
      'EXPIRED',
      name: 'clientJourneysExpired',
      desc: 'client Journeys Expired',
    );
  }

  String get clientJourneyDetailsAppBarTitle {
    return Intl.message(
      'JOURNEY DETAILS',
      name: 'clientJourneyDetailsAppBarTitle',
      desc: 'client Journey Details App Bar Title',
    );
  }

  String get clientJourneyDetailsDescriptionLabel {
    return Intl.message(
      'Description',
      name: 'clientJourneyDetailsDescriptionLabel',
      desc: 'client Journey details description label',
    );
  }

  String get localitySearchNoResultText {
    return Intl.message(
      'No results were found. Try to create a new location from map.',
      name: 'localitySearchNoResultText',
      desc: 'locality Search No Result Text',
    );
  }

  String get deleteJourneyRequestWarningTitle {
    return Intl.message(
      'DELETION OF JOURNEY REQUEST',
      name: 'deleteJourneyRequestWarningTitle',
      desc: 'delete Journey Request Warning Title',
    );
  }

  String get deleteJourneyRequestWarningText {
    return Intl.message(
      'Are you sure you want to remove this journey request?',
      name: 'deleteJourneyRequestWarningText',
      desc: 'delete Journey Request Warning Title',
    );
  }

  String get deleteJourneyRequestErrorMessage {
    return Intl.message(
      'Something went wrong. We were unable to delete this journey request. If problem persists, please contact support.',
      name: 'deleteJourneyRequestErrorMessage',
      desc: 'delete Journey Request Error Message',
    );
  }

  String get proposalsNoProposalsYetText {
    return Intl.message(
      'No offers yet.',
      name: 'proposalsNoProposalsYetText',
      desc: 'proposals No Proposals Yet Text',
    );
  }

  String get proposalsAppBarTitle {
    return Intl.message(
      'OFFERS',
      name: 'proposalsAppBarTitle',
      desc: 'proposals AppBar Title',
    );
  }

  String get proposalsRejectText {
    return Intl.message(
      'REJECT',
      name: 'proposalsRejectText',
      desc: 'proposals Reject Text',
    );
  }

  String get proposalsAcceptText {
    return Intl.message(
      'ACCEPT',
      name: 'proposalsAcceptText',
      desc: 'proposalsAcceptText',
    );
  }

  String get proposalsContactText {
    return Intl.message(
      'CONTACT',
      name: 'proposalsContactText',
      desc: 'proposals Contact Text',
    );
  }

  String proposalRejectedMessage(transporterName) =>
      Intl.message("Proposal of $transporterName rejected.",
          name: "proposalRejectedMessage",
          args: [transporterName],
          desc: "proposal Rejected Message",
          examples: const {'transporterName': "Eddy"});

  String proposalAcceptedMessage(transporterName) =>
      Intl.message("Proposal of $transporterName accepted.",
          name: "proposalAcceptedMessage",
          args: [transporterName],
          desc: "proposal Accepted Message",
          examples: const {'transporterName': "Eddy"});

  String get genericErrorMessage {
    return Intl.message(
      'Something went wrong. If problem persists, please contact support.',
      name: 'genericErrorMessage',
      desc: 'generic Error Message',
    );
  }

  String get proposalAcceptedText {
    return Intl.message(
      'ACCEPTED',
      name: 'proposal Accepted Text',
      desc: 'proposal Accepted Text',
    );
  }

  String get checkYourConnectionText {
    return Intl.message(
      'Unable to connect. Please check your Internet connection.',
      name: 'check Your Connection Text',
      desc: 'check Your Connection Text',
    );
  }

  String nullLengthValidationMessage(fieldName, min, max) => Intl.message(
      "$fieldName should have a length between $min and $max charaters",
      name: "nullLengthValidationMessage",
      args: [fieldName, min, max],
      desc: "null Length Validation Message",
      examples: const {'fieldName': "Firstname", "min": "2", "max": "15"});

  String minLengthValidationMessage(fieldName, min) =>
      Intl.message("$fieldName should have at least $min characters",
          name: "minLengthValidationMessage",
          args: [fieldName, min],
          desc: "min Length Validation Message",
          examples: const {'fieldName': 'Firstname', 'min': '2'});

  String maxLengthValidationMessage(fieldName, max) =>
      Intl.message("$fieldName should have at most $max characters",
          name: "maxLengthValidationMessage",
          args: [fieldName, max],
          desc: "max Length Validation Message",
          examples: const {'fieldName': 'Firstname', 'max': '15'});
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;
  static AppLocalizations? _instance;
  static AppLocalizations? get appLocalizations => _instance;

  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = await AppLocalizations.load(locale);
    _instance = appLocalizations;
    return appLocalizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
