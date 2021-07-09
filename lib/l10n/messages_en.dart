// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, always_declare_return_types

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(fieldName, max) => "${fieldName} should have at most ${max} characters";

  static m1(fieldName, min) => "${fieldName} should have at least ${min} characters";

  static m2(fieldName, min, max) => "${fieldName} should have a length between ${min} and ${max} charaters";

  static m3(transporterName) => "Proposal of ${transporterName} accepted.";

  static m4(transporterName) => "Proposal of ${transporterName} rejected.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "addFavoriteLocationAlertOk" : MessageLookupByLibrary.simpleMessage("OK"),
    "addFavoriteLocationAlertTitle" : MessageLookupByLibrary.simpleMessage("WARNING!"),
    "addFavoriteLocationAppBarTitle" : MessageLookupByLibrary.simpleMessage("ADD A PLACE"),
    "addFavoriteLocationChoosePlaceText" : MessageLookupByLibrary.simpleMessage("Choose a place"),
    "addFavoriteLocationLocateOnMapAppBarText" : MessageLookupByLibrary.simpleMessage("LOCATE ON MAP"),
    "addFavoriteLocationLocateOnMapText" : MessageLookupByLibrary.simpleMessage("Locate on map"),
    "addFavoriteLocationMissingPlaceLocation" : MessageLookupByLibrary.simpleMessage("Please select a place location before saving."),
    "addFavoriteLocationMissingPlaceName" : MessageLookupByLibrary.simpleMessage("Please give a place name before saving."),
    "addFavoriteLocationMyPositionText" : MessageLookupByLibrary.simpleMessage("My position"),
    "addFavoriteLocationPlaceNameLabel" : MessageLookupByLibrary.simpleMessage("Name"),
    "ageEmptyValidatorMessage" : MessageLookupByLibrary.simpleMessage("Birth date is mandatory."),
    "ageMaxValidatorMessage" : MessageLookupByLibrary.simpleMessage("You should be at most 100 years old."),
    "ageMinValidatorMessage" : MessageLookupByLibrary.simpleMessage("You should be at least 18 years old."),
    "applicationSettingsAppBarTitle" : MessageLookupByLibrary.simpleMessage("APPLICATION SETTINGS"),
    "applicationSettingsCountryText" : MessageLookupByLibrary.simpleMessage("Country:"),
    "applicationSettingsLanguageText" : MessageLookupByLibrary.simpleMessage("Language:"),
    "applicationSettingsTimeZoneText" : MessageLookupByLibrary.simpleMessage("Time zone:"),
    "authenticationBadCredentialsText" : MessageLookupByLibrary.simpleMessage("Login or password are incorrect."),
    "authenticationMotto" : MessageLookupByLibrary.simpleMessage("Finding a carrier has never been easier!"),
    "authenticationSigninText" : MessageLookupByLibrary.simpleMessage("SIGN IN"),
    "authenticationSignupText" : MessageLookupByLibrary.simpleMessage("SIGN UP"),
    "cancelButtonText" : MessageLookupByLibrary.simpleMessage("CANCEL"),
    "checkYourConnectionText" : MessageLookupByLibrary.simpleMessage("Unable to connect. Please check your Internet connection."),
    "chooseUserTypeAppBarText" : MessageLookupByLibrary.simpleMessage("ACCOUNT TYPE"),
    "chooseUserTypeCustomerLabel" : MessageLookupByLibrary.simpleMessage("Customer:"),
    "chooseUserTypeErrorText" : MessageLookupByLibrary.simpleMessage("Please select an account type."),
    "chooseUserTypeHeaderText" : MessageLookupByLibrary.simpleMessage("Which kind of user are you?"),
    "chooseUserTypeTransporterLabel" : MessageLookupByLibrary.simpleMessage("Transporter:"),
    "clearTooltipText" : MessageLookupByLibrary.simpleMessage("Clear"),
    "clientJourneyDetailsAppBarTitle" : MessageLookupByLibrary.simpleMessage("JOURNEY DETAILS"),
    "clientJourneyDetailsDescriptionLabel" : MessageLookupByLibrary.simpleMessage("Description"),
    "clientJourneysAppBarTitle" : MessageLookupByLibrary.simpleMessage("MY JOURNEYS"),
    "clientJourneysEmptyText" : MessageLookupByLibrary.simpleMessage("You have no journey requests for the chosen period."),
    "clientJourneysExpired" : MessageLookupByLibrary.simpleMessage("EXPIRED"),
    "clientJourneysFilterLastMonth" : MessageLookupByLibrary.simpleMessage("Last month"),
    "clientJourneysFilterLastQuarter" : MessageLookupByLibrary.simpleMessage("Last quarter"),
    "clientJourneysFilterLastSemester" : MessageLookupByLibrary.simpleMessage("Last semester"),
    "clientJourneysFilterLastWeek" : MessageLookupByLibrary.simpleMessage("Last week"),
    "clientJourneysFilterLastYear" : MessageLookupByLibrary.simpleMessage("Last year"),
    "clientJourneysInfoTooltip" : MessageLookupByLibrary.simpleMessage("Details"),
    "clientJourneysOpened" : MessageLookupByLibrary.simpleMessage("OPEN"),
    "clientJourneysProposalsTooltip" : MessageLookupByLibrary.simpleMessage("Offers"),
    "clientJourneysSortDateAsc" : MessageLookupByLibrary.simpleMessage("Oldest first"),
    "clientJourneysSortDateDesc" : MessageLookupByLibrary.simpleMessage("Latest first"),
    "closeTooltipText" : MessageLookupByLibrary.simpleMessage("Close"),
    "createJourneyAppBarTitle" : MessageLookupByLibrary.simpleMessage("JOURNEY REQUEST"),
    "createJourneyArrivalLabel" : MessageLookupByLibrary.simpleMessage("Arrival"),
    "createJourneyArrivalValidatorMessage" : MessageLookupByLibrary.simpleMessage("Arrival is mandatory."),
    "createJourneyDateLabel" : MessageLookupByLibrary.simpleMessage("Date"),
    "createJourneyDateValidatorMessage" : MessageLookupByLibrary.simpleMessage("Date is mandatory."),
    "createJourneyDepartureLabel" : MessageLookupByLibrary.simpleMessage("Departure"),
    "createJourneyDepartureValidatorMessage" : MessageLookupByLibrary.simpleMessage("Departure is mandatory."),
    "createJourneyDescriptionLabel" : MessageLookupByLibrary.simpleMessage("Describe your request"),
    "createJourneyDescriptionValidatorMessage" : MessageLookupByLibrary.simpleMessage("Description is mandatory."),
    "createJourneyHandlersLabel" : MessageLookupByLibrary.simpleMessage("Handlers"),
    "createJourneyHeaderText" : MessageLookupByLibrary.simpleMessage("Detail your request:"),
    "createJourneyTimeLabel" : MessageLookupByLibrary.simpleMessage("Time"),
    "createJourneyTimeValidatorMessage" : MessageLookupByLibrary.simpleMessage("Time is mandatory."),
    "createJourneyVehiculeLabel" : MessageLookupByLibrary.simpleMessage("Vehicule"),
    "createJourneyVehiculeValidatorMessage" : MessageLookupByLibrary.simpleMessage("Vehicule is mandatory."),
    "dateBeforeValidatorMessage" : MessageLookupByLibrary.simpleMessage("Start date should be before end date."),
    "deleteButtonText" : MessageLookupByLibrary.simpleMessage("DELETE"),
    "deleteJourneyRequestErrorMessage" : MessageLookupByLibrary.simpleMessage("Something went wrong. We were unable to delete this journey request. If problem persists, please contact support."),
    "deleteJourneyRequestWarningText" : MessageLookupByLibrary.simpleMessage("Are you sure you want to remove this journey request?"),
    "deleteJourneyRequestWarningTitle" : MessageLookupByLibrary.simpleMessage("DELETION OF JOURNEY REQUEST"),
    "doneTooltipText" : MessageLookupByLibrary.simpleMessage("Done"),
    "editButtonText" : MessageLookupByLibrary.simpleMessage("EDIT"),
    "emailValidatorMessage" : MessageLookupByLibrary.simpleMessage("E-mail is incorrect."),
    "favoritePlacesAppBarTitle" : MessageLookupByLibrary.simpleMessage("FAVORITE PLACES"),
    "favoritePlacesEmptyText" : MessageLookupByLibrary.simpleMessage("You do not have favorite places yet."),
    "genericErrorMessage" : MessageLookupByLibrary.simpleMessage("Something went wrong. If problem persists, please contact support."),
    "homeDemandText" : MessageLookupByLibrary.simpleMessage("Demand"),
    "homeDiscussionsText" : MessageLookupByLibrary.simpleMessage("Discussions"),
    "homeJourneysText" : MessageLookupByLibrary.simpleMessage("Journeys"),
    "homeProfileText" : MessageLookupByLibrary.simpleMessage("Profile"),
    "homeSearchText" : MessageLookupByLibrary.simpleMessage("Search"),
    "loadingText" : MessageLookupByLibrary.simpleMessage("Loading..."),
    "localitySearchHelpText" : MessageLookupByLibrary.simpleMessage("Type a locality name"),
    "localitySearchNoResultText" : MessageLookupByLibrary.simpleMessage("No results were found. Try to create a new location from map."),
    "loginValidatorMessage" : MessageLookupByLibrary.simpleMessage("E-mail or mobile number is incorrect."),
    "maxLengthValidationMessage" : m0,
    "minLengthValidationMessage" : m1,
    "mobileNumberCheckConfirm" : MessageLookupByLibrary.simpleMessage("CONFIRM"),
    "mobileNumberCheckMobileNumberConfirmationTitle" : MessageLookupByLibrary.simpleMessage("Mobile number confirmation"),
    "mobileValidationSMSCodeErrorMessage" : MessageLookupByLibrary.simpleMessage("Your mobile number validation code is wrong!"),
    "mobileValidationSMSCodeResend" : MessageLookupByLibrary.simpleMessage("RESEND SMS"),
    "mobileValidationSMSCodeSuccessMessage" : MessageLookupByLibrary.simpleMessage("Your mobile number was validated succesfully!"),
    "mobileValidationSMSCodeText" : MessageLookupByLibrary.simpleMessage("An SMS containing your validation code was sent to your mobile. Please type the received code."),
    "mobileValidationSMSCodeTitle" : MessageLookupByLibrary.simpleMessage("Mobile number validation"),
    "mobileValidationSMSCodeValidate" : MessageLookupByLibrary.simpleMessage("VALIDATE"),
    "mobileValidationSMSResentMessage" : MessageLookupByLibrary.simpleMessage("An SMS was resent to your mobile number. It may take up to 10 minutes to be received."),
    "newTooltipText" : MessageLookupByLibrary.simpleMessage("New"),
    "nextButtonText" : MessageLookupByLibrary.simpleMessage("NEXT"),
    "nullLengthValidationMessage" : m2,
    "okButtonText" : MessageLookupByLibrary.simpleMessage("OK"),
    "passwordValidatorMessage" : MessageLookupByLibrary.simpleMessage("Password should contain at least 8 characters."),
    "phoneValidatorMessage" : MessageLookupByLibrary.simpleMessage("Mobile number is incorrect."),
    "proposalAcceptedMessage" : m3,
    "proposalRejectedMessage" : m4,
    "proposalsAcceptText" : MessageLookupByLibrary.simpleMessage("ACCEPT"),
    "proposalsAppBarTitle" : MessageLookupByLibrary.simpleMessage("OFFERS"),
    "proposalsContactText" : MessageLookupByLibrary.simpleMessage("CONTACT"),
    "proposalsNoProposalsYetText" : MessageLookupByLibrary.simpleMessage("No offers yet."),
    "proposalsRejectText" : MessageLookupByLibrary.simpleMessage("REJECT"),
    "publishButtonText" : MessageLookupByLibrary.simpleMessage("PUBLISH"),
    "resetButtonText" : MessageLookupByLibrary.simpleMessage("RESET"),
    "resetPasswordAppBarTitle" : MessageLookupByLibrary.simpleMessage("PASSWORD RESET"),
    "resetPasswordResultText" : MessageLookupByLibrary.simpleMessage("If login exists, an E-mail or SMS containing password reset link will be sent to you within 10 minutes."),
    "saveButtonText" : MessageLookupByLibrary.simpleMessage("SAVE"),
    "signInForgottenPasswordText" : MessageLookupByLibrary.simpleMessage("Forgot password?"),
    "signInLoginLabel" : MessageLookupByLibrary.simpleMessage("E-mail OR Mobile number"),
    "signInNotYetMemeberSignUpText" : MessageLookupByLibrary.simpleMessage("NOT YET MEMBER? -> SIGN UP"),
    "signInPasswordLabel" : MessageLookupByLibrary.simpleMessage("Password"),
    "signUpAlreadyMemberSignInText" : MessageLookupByLibrary.simpleMessage("ALREADY MEMBER? SIGN IN"),
    "signUpAppBarTitle" : MessageLookupByLibrary.simpleMessage("SIGN UP"),
    "signUpAppButtonText" : MessageLookupByLibrary.simpleMessage("SIGN UP"),
    "signUpBirthDateLabel" : MessageLookupByLibrary.simpleMessage("Birth date"),
    "signUpConfirmPasswordLabel" : MessageLookupByLibrary.simpleMessage("Password confirmation"),
    "signUpEmailLabel" : MessageLookupByLibrary.simpleMessage("E-mail"),
    "signUpFirstnameLabel" : MessageLookupByLibrary.simpleMessage("Firstname"),
    "signUpFirstnameValidationMessage" : MessageLookupByLibrary.simpleMessage("Firstname is mandatory."),
    "signUpGenderLabel" : MessageLookupByLibrary.simpleMessage("Gender"),
    "signUpLastnameLabel" : MessageLookupByLibrary.simpleMessage("Lastname"),
    "signUpLastnameValidationMessage" : MessageLookupByLibrary.simpleMessage("Lastname is mandatory."),
    "signUpMobileNumberLabel" : MessageLookupByLibrary.simpleMessage("Mobile number"),
    "signUpPasswordLabel" : MessageLookupByLibrary.simpleMessage("Password (8 characters min)"),
    "signUpPasswordValidationMessage" : MessageLookupByLibrary.simpleMessage("Password does not correspond to confirmation."),
    "signUpSubscribeNewsletterText" : MessageLookupByLibrary.simpleMessage("Receive promotions and good deals?"),
    "signUpTOS1" : MessageLookupByLibrary.simpleMessage("By signing up, you accept, without reservations, our "),
    "signUpTOS2" : MessageLookupByLibrary.simpleMessage("terms of service "),
    "signUpTOS3" : MessageLookupByLibrary.simpleMessage("and our "),
    "signUpTOS4" : MessageLookupByLibrary.simpleMessage("privacy policy."),
    "signUpUnavailableText" : MessageLookupByLibrary.simpleMessage("Signing up is temporarily unavailable. Please try again later."),
    "somethingWentWrongText" : MessageLookupByLibrary.simpleMessage("An error occured while processing your request. Please contact support team if error persists."),
    "updateButtonText" : MessageLookupByLibrary.simpleMessage("UPDATE"),
    "validateMobileAlertText1" : MessageLookupByLibrary.simpleMessage("Your mobile number is not yet validated."),
    "validateMobileAlertText2" : MessageLookupByLibrary.simpleMessage("Please validate it before proceeding."),
    "validateMobileAlertTitle" : MessageLookupByLibrary.simpleMessage("Mobile validation required")
  };
}
