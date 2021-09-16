// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static m0(fieldName, max) => "${fieldName} doit avoir au plus ${max} caractères.";

  static m1(fieldName, min) => "${fieldName} doit avoir au moins ${min} caractères.";

  static m2(fieldName, min, max) => "le champ ${fieldName} doit avoir une longeur comprise entre ${min} et ${max}.";

  static m3(transporterName) => "La proposition de ${transporterName} a été acceptée.";

  static m4(transporterName) => "La proposition de ${transporterName} a été rejetée.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function> {
    "addFavoriteLocationAlertOk" : MessageLookupByLibrary.simpleMessage("OK"),
    "addFavoriteLocationAlertTitle" : MessageLookupByLibrary.simpleMessage("ATTENTION!"),
    "addFavoriteLocationAppBarTitle" : MessageLookupByLibrary.simpleMessage("AJOUTER UN EMPLACEMENT"),
    "addFavoriteLocationChoosePlaceText" : MessageLookupByLibrary.simpleMessage("Choisissez un emplacement"),
    "addFavoriteLocationLocateOnMapAppBarText" : MessageLookupByLibrary.simpleMessage("LOCALISER SUR CARTE"),
    "addFavoriteLocationLocateOnMapText" : MessageLookupByLibrary.simpleMessage("Localiser sur carte"),
    "addFavoriteLocationMissingPlaceLocation" : MessageLookupByLibrary.simpleMessage("Veuillez choisir un emplacment avant de sauvegrader"),
    "addFavoriteLocationMissingPlaceName" : MessageLookupByLibrary.simpleMessage("Veuillez saisir un nom d\'emplacment avant de sauvegrader."),
    "addFavoriteLocationMyPositionText" : MessageLookupByLibrary.simpleMessage("Ma position"),
    "addFavoriteLocationPlaceNameLabel" : MessageLookupByLibrary.simpleMessage("Nom"),
    "ageEmptyValidatorMessage" : MessageLookupByLibrary.simpleMessage("La date de naissance est obligatoire."),
    "ageMaxValidatorMessage" : MessageLookupByLibrary.simpleMessage("Vous devez avoir moins de 100 ans."),
    "ageMinValidatorMessage" : MessageLookupByLibrary.simpleMessage("Vous devez avoir au moins 18 ans."),
    "applicationSettingsAppBarTitle" : MessageLookupByLibrary.simpleMessage("PARAMÈTRES D\'APPLICATION"),
    "applicationSettingsCountryText" : MessageLookupByLibrary.simpleMessage("Pays:"),
    "applicationSettingsLanguageText" : MessageLookupByLibrary.simpleMessage("Langue:"),
    "applicationSettingsTimeZoneText" : MessageLookupByLibrary.simpleMessage("Fuseau horaire:"),
    "authenticationBadCredentialsText" : MessageLookupByLibrary.simpleMessage("Login ou mot de passe incorrect."),
    "authenticationMotto" : MessageLookupByLibrary.simpleMessage("Trouver un transporteur n\'a jamais été aussi facile!"),
    "authenticationSigninText" : MessageLookupByLibrary.simpleMessage("CONNEXION"),
    "authenticationSignupText" : MessageLookupByLibrary.simpleMessage("INSCRIPTION"),
    "cancelButtonText" : MessageLookupByLibrary.simpleMessage("ANNULER"),
    "checkYourConnectionText" : MessageLookupByLibrary.simpleMessage("Impossible de se connecter. Veuillez vérifier votre connexion Internet."),
    "chooseUserTypeAppBarText" : MessageLookupByLibrary.simpleMessage("TYPE DE COMPTE"),
    "chooseUserTypeCustomerLabel" : MessageLookupByLibrary.simpleMessage("Client:"),
    "chooseUserTypeErrorText" : MessageLookupByLibrary.simpleMessage("Veuillez sélectionner un type de compte."),
    "chooseUserTypeHeaderText" : MessageLookupByLibrary.simpleMessage("Quel type d\'utilisateur êtes vous?"),
    "chooseUserTypeTransporterLabel" : MessageLookupByLibrary.simpleMessage("Transporteur:"),
    "clearTooltipText" : MessageLookupByLibrary.simpleMessage("Effacer"),
    "clientJourneyDetailsAppBarTitle" : MessageLookupByLibrary.simpleMessage("DETAILS DU TRAJET"),
    "clientJourneyDetailsDescriptionLabel" : MessageLookupByLibrary.simpleMessage("Description"),
    "clientJourneysAppBarTitle" : MessageLookupByLibrary.simpleMessage("MES TRAJETS"),
    "clientJourneysEmptyText" : MessageLookupByLibrary.simpleMessage("Vous n\'avez aucun trajet pendant la période choisie."),
    "clientJourneysExpired" : MessageLookupByLibrary.simpleMessage("EXPIRÉ"),
    "clientJourneysFilterLastMonth" : MessageLookupByLibrary.simpleMessage("Mois dernier"),
    "clientJourneysFilterLastQuarter" : MessageLookupByLibrary.simpleMessage("Trimestre dernier"),
    "clientJourneysFilterLastSemester" : MessageLookupByLibrary.simpleMessage("Dernier semestere"),
    "clientJourneysFilterLastWeek" : MessageLookupByLibrary.simpleMessage("Semaine dernière"),
    "clientJourneysFilterLastYear" : MessageLookupByLibrary.simpleMessage("Dernière année"),
    "clientJourneysInfoTooltip" : MessageLookupByLibrary.simpleMessage("Détails"),
    "clientJourneysOpened" : MessageLookupByLibrary.simpleMessage("OUVERT"),
    "clientJourneysProposalsTooltip" : MessageLookupByLibrary.simpleMessage("Offres"),
    "clientJourneysSortDateAsc" : MessageLookupByLibrary.simpleMessage("Plus ancien en premier"),
    "clientJourneysSortDateDesc" : MessageLookupByLibrary.simpleMessage("Plus récent en premier"),
    "closeTooltipText" : MessageLookupByLibrary.simpleMessage("Fermer"),
    "createJourneyAppBarTitle" : MessageLookupByLibrary.simpleMessage("DEMANDE DE TRAJET"),
    "createJourneyArrivalLabel" : MessageLookupByLibrary.simpleMessage("Arrivée"),
    "createJourneyArrivalValidatorMessage" : MessageLookupByLibrary.simpleMessage("L\'arrivée est obligatoire."),
    "createJourneyDateLabel" : MessageLookupByLibrary.simpleMessage("Date"),
    "createJourneyDateValidatorMessage" : MessageLookupByLibrary.simpleMessage("La date est obligatoire."),
    "createJourneyDepartureLabel" : MessageLookupByLibrary.simpleMessage("Départ"),
    "createJourneyDepartureValidatorMessage" : MessageLookupByLibrary.simpleMessage("Le départ est obligatoire."),
    "createJourneyDescriptionLabel" : MessageLookupByLibrary.simpleMessage("Décrivez votre demande"),
    "createJourneyDescriptionValidatorMessage" : MessageLookupByLibrary.simpleMessage("La description est obligatoire."),
    "createJourneyHandlersLabel" : MessageLookupByLibrary.simpleMessage("Manutentionnaires"),
    "createJourneyHeaderText" : MessageLookupByLibrary.simpleMessage("Détaillez votre demande:"),
    "createJourneyTimeLabel" : MessageLookupByLibrary.simpleMessage("Heure"),
    "createJourneyTimeValidatorMessage" : MessageLookupByLibrary.simpleMessage("L\'heure est obligatoire."),
    "createJourneyVehiculeLabel" : MessageLookupByLibrary.simpleMessage("Véhicule"),
    "createJourneyVehiculeValidatorMessage" : MessageLookupByLibrary.simpleMessage("Le véhicule est obligatoire."),
    "dateBeforeValidatorMessage" : MessageLookupByLibrary.simpleMessage("La date de début doit être avant la date de fin."),
    "deleteButtonText" : MessageLookupByLibrary.simpleMessage("SUPPRIMER"),
    "deleteJourneyRequestErrorMessage" : MessageLookupByLibrary.simpleMessage("Une erreur s\'est produite. Inpossible de supprimer cette demande. Si le problème persiste, veuillez contacter le support."),
    "deleteJourneyRequestSuccessMessage" : MessageLookupByLibrary.simpleMessage("Demande de trajet supprimée avec succès."),
    "deleteJourneyRequestWarningText" : MessageLookupByLibrary.simpleMessage("Êtes vous sûr de vouloir supprimer cette demande de trajet?"),
    "deleteJourneyRequestWarningTitle" : MessageLookupByLibrary.simpleMessage("SUPPRESSION DE DEMANDE DE TRAJET"),
    "discussionsAppBarTitle" : MessageLookupByLibrary.simpleMessage("DISCUSSIONS"),
    "doneTooltipText" : MessageLookupByLibrary.simpleMessage("Terminer"),
    "editButtonText" : MessageLookupByLibrary.simpleMessage("EDITER"),
    "emailValidatorMessage" : MessageLookupByLibrary.simpleMessage("E-mail incorrect."),
    "favoritePlacesAppBarTitle" : MessageLookupByLibrary.simpleMessage("EMPLACEMENTS FAVORIS"),
    "favoritePlacesEmptyText" : MessageLookupByLibrary.simpleMessage("Vous n\'avez pas encore créé des emplacements favoris."),
    "genericErrorMessage" : MessageLookupByLibrary.simpleMessage("Une erreur s\'est produite. Si le problème persiste, veuillez contacter le support."),
    "homeDemandText" : MessageLookupByLibrary.simpleMessage("Demande"),
    "homeDiscussionsText" : MessageLookupByLibrary.simpleMessage("Discussions"),
    "homeJourneysText" : MessageLookupByLibrary.simpleMessage("Trajets"),
    "homeProfileText" : MessageLookupByLibrary.simpleMessage("Profil"),
    "homeSearchText" : MessageLookupByLibrary.simpleMessage("Recherche"),
    "loadingText" : MessageLookupByLibrary.simpleMessage("Chargement..."),
    "localitySearchHelpText" : MessageLookupByLibrary.simpleMessage("Saisissez un nom de localité"),
    "localitySearchNoResultText" : MessageLookupByLibrary.simpleMessage("Aucun résultat trouvé. Essayer de créer un nouvel emplacements sur la carte."),
    "loginValidatorMessage" : MessageLookupByLibrary.simpleMessage("E-mail ou numéro mobile incorrect."),
    "maxLengthValidationMessage" : m0,
    "minLengthValidationMessage" : m1,
    "mobileNumberCheckConfirm" : MessageLookupByLibrary.simpleMessage("CONFIRMER"),
    "mobileNumberCheckMobileNumberConfirmationTitle" : MessageLookupByLibrary.simpleMessage("Confirmation du numéro mobile"),
    "mobileValidationSMSCodeErrorMessage" : MessageLookupByLibrary.simpleMessage("Votre code de validation est incorrect!"),
    "mobileValidationSMSCodeResend" : MessageLookupByLibrary.simpleMessage("RENVOYER LE SMS"),
    "mobileValidationSMSCodeSuccessMessage" : MessageLookupByLibrary.simpleMessage("Votre numéro de téléphone mobile a été validé avec succès!"),
    "mobileValidationSMSCodeText" : MessageLookupByLibrary.simpleMessage("Un SMS contenant votre code de validation a été envoyé à votre téléphone mobile. Veuillez saisir le code reçu."),
    "mobileValidationSMSCodeTitle" : MessageLookupByLibrary.simpleMessage("Validation du numéro mobile"),
    "mobileValidationSMSCodeValidate" : MessageLookupByLibrary.simpleMessage("VALIDER"),
    "mobileValidationSMSResentMessage" : MessageLookupByLibrary.simpleMessage("Un SMS a été envoyé à votre mobile. Il peut mettre jusqu\'à 10 minutes avant que vous le recervrez."),
    "newTooltipText" : MessageLookupByLibrary.simpleMessage("Nouveau"),
    "nextButtonText" : MessageLookupByLibrary.simpleMessage("SUIVANT"),
    "nullLengthValidationMessage" : m2,
    "okButtonText" : MessageLookupByLibrary.simpleMessage("OK"),
    "passwordValidatorMessage" : MessageLookupByLibrary.simpleMessage("Le mot de passe doit contenir au moins 8 caractères."),
    "phoneValidatorMessage" : MessageLookupByLibrary.simpleMessage("Numéro mobile incorrect."),
    "proposalAcceptedMessage" : m3,
    "proposalRejectedMessage" : m4,
    "proposalsAcceptText" : MessageLookupByLibrary.simpleMessage("ACCEPTER"),
    "proposalsAppBarTitle" : MessageLookupByLibrary.simpleMessage("PROPOSITIONS"),
    "proposalsContactText" : MessageLookupByLibrary.simpleMessage("CONTACTER"),
    "proposalsNoProposalsYetText" : MessageLookupByLibrary.simpleMessage("Pas encore de propositions."),
    "proposalsRejectText" : MessageLookupByLibrary.simpleMessage("RJETER"),
    "publishButtonText" : MessageLookupByLibrary.simpleMessage("PUBLIER"),
    "resetButtonText" : MessageLookupByLibrary.simpleMessage("RÉINITIALISER"),
    "resetPasswordAppBarTitle" : MessageLookupByLibrary.simpleMessage("RÉINITILISATION DE MOT DE PASSE"),
    "resetPasswordResultText" : MessageLookupByLibrary.simpleMessage("Si le login existe, un E-mail ou SMS contenant un lien de réinitialisation vous sera envoyé sous 10 minutes."),
    "saveButtonText" : MessageLookupByLibrary.simpleMessage("ENREGISTRER"),
    "signInForgottenPasswordText" : MessageLookupByLibrary.simpleMessage("Mot de passe oublié?"),
    "signInLoginLabel" : MessageLookupByLibrary.simpleMessage("E-mail OU numéro mobile"),
    "signInNotYetMemeberSignUpText" : MessageLookupByLibrary.simpleMessage("PAS ENCORE MEMBRE? -> INSCRIPTION"),
    "signInPasswordLabel" : MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "signUpAlreadyMemberSignInText" : MessageLookupByLibrary.simpleMessage("DÉJA MEMBRE? CONNEXION"),
    "signUpAppBarTitle" : MessageLookupByLibrary.simpleMessage("INSCRIPTION"),
    "signUpAppButtonText" : MessageLookupByLibrary.simpleMessage("S\'INSCRIRE"),
    "signUpBirthDateLabel" : MessageLookupByLibrary.simpleMessage("Date de naissance"),
    "signUpConfirmPasswordLabel" : MessageLookupByLibrary.simpleMessage("Confirmation du mot de passe"),
    "signUpEmailLabel" : MessageLookupByLibrary.simpleMessage("E-mail"),
    "signUpFirstnameLabel" : MessageLookupByLibrary.simpleMessage("Prénom"),
    "signUpFirstnameValidationMessage" : MessageLookupByLibrary.simpleMessage("Le prénom est obligatoire."),
    "signUpGenderLabel" : MessageLookupByLibrary.simpleMessage("Sexe"),
    "signUpLastnameLabel" : MessageLookupByLibrary.simpleMessage("Nom"),
    "signUpLastnameValidationMessage" : MessageLookupByLibrary.simpleMessage("Le nom de famille est obligatoire."),
    "signUpMobileNumberLabel" : MessageLookupByLibrary.simpleMessage("Numéro mobile"),
    "signUpPasswordLabel" : MessageLookupByLibrary.simpleMessage("Mot de passe (8 caractères min)"),
    "signUpPasswordValidationMessage" : MessageLookupByLibrary.simpleMessage("Le mot de passe ne correspond pas à sa confirmation."),
    "signUpSubscribeNewsletterText" : MessageLookupByLibrary.simpleMessage("Recevoir les promotions et bons plans?"),
    "signUpTOS1" : MessageLookupByLibrary.simpleMessage("En vous inscrivant, vous acceptez, sans réserves, nos "),
    "signUpTOS2" : MessageLookupByLibrary.simpleMessage("conditions générales d\'utilisation "),
    "signUpTOS3" : MessageLookupByLibrary.simpleMessage("et notre "),
    "signUpTOS4" : MessageLookupByLibrary.simpleMessage("politique de confidentialité."),
    "signUpUnavailableText" : MessageLookupByLibrary.simpleMessage("L\'inscription est temporairement indisponible. Veuillez réessayer plus tard."),
    "somethingWentWrongText" : MessageLookupByLibrary.simpleMessage("Une erreur s\'est produite pendant le traitement de votre demande. Veuillez contacter le support si le problème persiste."),
    "updateButtonText" : MessageLookupByLibrary.simpleMessage("MODIFIER"),
    "validateMobileAlertText1" : MessageLookupByLibrary.simpleMessage("Votre numéro mobile n\'est pas encore validé."),
    "validateMobileAlertText2" : MessageLookupByLibrary.simpleMessage("Veuillez le valider avant de continuer."),
    "validateMobileAlertTitle" : MessageLookupByLibrary.simpleMessage("Validation de mobile obligatoire")
  };
}
