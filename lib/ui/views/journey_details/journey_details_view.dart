import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/client_journey_request_dto.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'journey_details_viewmodel.dart';

class JourneyDetailsView extends StatelessWidget {
  final ClientJourneyRequestDto journeyRequest;
  JourneyDetailsView({Key? key, required this.journeyRequest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneyDetailsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
              AppLocalizations.of(context)!.clientJourneyDetailsAppBarTitle),
          actions: [],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(children: [
                          Row(children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text(
                                  AppLocalizations.of(context)!
                                          .createJourneyDepartureLabel +
                                      ':',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 5,
                                child: Text(journeyRequest.departurePlace.name))
                          ]),
                          Divider(),
                          Row(children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text(
                                  AppLocalizations.of(context)!
                                          .createJourneyArrivalLabel +
                                      ':',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 5,
                                child: Text(journeyRequest.arrivalPlace.name))
                          ]),
                          Divider(),
                          Row(children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text(
                                  AppLocalizations.of(context)!
                                          .createJourneyVehiculeLabel +
                                      ':',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 5,
                                child: Text(journeyRequest.engineType.name))
                          ]),
                          Divider(),
                          Row(children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text(
                                  AppLocalizations.of(context)!
                                          .createJourneyDateLabel +
                                      ':',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 5,
                                child: Text(DateFormat.yMMMMd()
                                        .format(journeyRequest.dateTime) +
                                    ' ' +
                                    DateFormat.jm()
                                        .format(journeyRequest.dateTime)))
                          ]),
                          Divider(),
                          Row(children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text(
                                  AppLocalizations.of(context)!
                                          .createJourneyHandlersLabel +
                                      ':',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 5,
                                child: Text(journeyRequest.workers.toString()))
                          ]),
                          Divider(),
                          Row(children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: Text(
                                  AppLocalizations.of(context)!
                                          .clientJourneyDetailsDescriptionLabel +
                                      ':',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 5,
                                child: Text(journeyRequest.description))
                          ])
                        ])))),
          ],
        ),
        floatingActionButton: Visibility(
          child: FloatingActionButton(
            onPressed: () {
              model.navigateToEditJourneyRequest(journeyRequest);
            },
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          visible: journeyRequest.dateTime.isAfter(DateTime.now()),
        ),
      ),
      viewModelBuilder: () => JourneyDetailsViewModel(),
    );
  }
}
