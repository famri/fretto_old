import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/ui/shared/colors.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

import 'api/local_storage_api.dart';
import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'l10n/locale/app_localizations.dart';

void main() async {
  /* ENSURE ASYNC WILL NOT GENERATE RUNTIME ERROR */
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  /* ACCEPTS LOCALLY GENERATED TLS CERTIFICATE FOR HTTP REQUESTS */
  HttpOverrides.global = new MyHttpOverrides();
  /* REGISTER DEPENDENCIES */
  await setupLocator();
  runApp(Fretto());
}

class Fretto extends StatefulWidget {
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_FrettoState>()!.restartApp();
  }

  @override
  _FrettoState createState() => _FrettoState();
}

class _FrettoState extends State<Fretto> {
  ApplicationSettingsService _applicationSettingsService =
      locator<ApplicationSettingsService>();

  String _userLocaleLanguage = 'en';
  String _userLocaleCountry = 'US';

  AppLocalizationDelegate _localeOverrideDelegate =
      AppLocalizationDelegate(Locale('en', 'US'));

  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
      if (_applicationSettingsService.applicationSettings != null) {
        _userLocaleLanguage =
            _applicationSettingsService.applicationSettings!.userLocaleLanguage;
        _userLocaleCountry =
            _applicationSettingsService.applicationSettings!.userLocaleCountry;
      }
    });
  }

  @override
  void initState() {
    if (_applicationSettingsService.applicationSettings != null) {
      _userLocaleLanguage =
          _applicationSettingsService.applicationSettings!.userLocaleLanguage;
      _userLocaleCountry =
          _applicationSettingsService.applicationSettings!.userLocaleCountry;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key,
      navigatorKey: StackedService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'FRETTO',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: kcAccentColor,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Color(0xff265B64)),
              headline2: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Color(0xff265B64)),
              headline3: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Color(0xff265B64)),
              headline4: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Color(0xff265B64)),
              headline5: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.normal,
                  fontSize: 12.0,
                  color: Color(0xff265B64)),
              bodyText1:
                  TextStyle(fontFamily: 'OpenSans', color: Color(0xff265B64)),
              button: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          )),
      localizationsDelegates: [
        _localeOverrideDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('fr', 'FR'),
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        Locale? mostAccurateLocale;
        bool isFirstLoacale = true;
        //if locale is saved to shared preferences, then use it

        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == _userLocaleLanguage) {
            if (isFirstLoacale) {
              mostAccurateLocale = supportedLocale;
              isFirstLoacale = false;
            }
            if (supportedLocale.countryCode == _userLocaleCountry) {
              Intl.defaultLocale = supportedLocale.toString();
              return supportedLocale;
            }
          }
        }
        if (mostAccurateLocale != null) {
          Intl.defaultLocale = mostAccurateLocale.toString();
          return mostAccurateLocale;
        }

        if (deviceLocale == null) {
          Intl.defaultLocale = supportedLocales.first.toString();
          return supportedLocales.first;
        }
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == deviceLocale.languageCode) {
            Intl.defaultLocale = supportedLocale.toString();
            return supportedLocale;
          }
        }
        Intl.defaultLocale = supportedLocales.first.toLanguageTag();
        return supportedLocales.first;
      },
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
