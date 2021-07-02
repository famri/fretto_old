import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/place_suggestion.dart';
import 'package:fretto/services/application_settings_service.dart';
import 'package:fretto/services/place_service.dart';

class LocalitySearch extends SearchDelegate<PlaceSuggestion?> {
  final PlaceService _placeService = locator<PlaceService>();
  final ApplicationSettingsService _applicationSettingsService =
      locator<ApplicationSettingsService>();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: AppLocalizations.of(context)!.clearTooltipText,
        icon: Icon(Icons.backspace),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context)!.closeTooltipText,
      icon: Icon(Icons.clear),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      children: [],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<PlaceSuggestion>>(
      future: (query == '' || query.length < 3)
          ? null
          : _placeService.loadPlaceSuggestions(
              query,
              _applicationSettingsService
                  .applicationSettings!.userLocaleLanguage,
              _applicationSettingsService
                  .applicationSettings!.userLocaleCountry,
              _applicationSettingsService.applicationSettings!.userCountryCode,
              5),
      builder: (context, snapshot) {
        if (query == '') {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Text(AppLocalizations.of(context)!.localitySearchHelpText),
          );
        } else if (snapshot.hasData) {
          if ((snapshot.data as List).isEmpty) {
            return Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                    AppLocalizations.of(context)!.localitySearchNoResultText));
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text(buildPlaceSuggestionTitle(snapshot.data![index])),
                onTap: () {
                  close(context,
                      (snapshot.data as List)[index] as PlaceSuggestion);
                },
              ),
              itemCount: snapshot.data!.length,
            );
          }
        } else {
          return Container(
              padding: EdgeInsets.all(16.0),
              child: Text(AppLocalizations.of(context)!.loadingText));
        }
      },
    );
  }

  static String buildPlaceSuggestionTitle(PlaceSuggestion placeSuggestion) {
    switch (placeSuggestion.type) {
      case "LOCALITY":
        return placeSuggestion.name +
            ', ' +
            placeSuggestion.delegation +
            ', ' +
            placeSuggestion.department;
      case "DELEGATION":
        return placeSuggestion.name + ', ' + placeSuggestion.department;
      case "DEPARTMENT":
        return placeSuggestion.name + ', ' + placeSuggestion.country;
      default:
        return 'UNKNOWN PLACE TYPE';
    }
  }
}
