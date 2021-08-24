import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/utils/engine_type_helper.dart';
import 'package:stacked/stacked.dart';

import 'journey_requests_viewmodel.dart';

class JourneyRequestsView extends StatelessWidget {
  JourneyRequestsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<JourneyRequestsViewModel>.reactive(
      onModelReady: (model) => model.initialize(),
      disposeViewModel: false,
      fireOnModelReadyOnce: true,

      //initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizationDelegate
                .appLocalizations!.clientJourneysAppBarTitle),
            actions: [
              PopupMenuButton<String>(
                  icon: Icon(
                    Icons.sort_outlined,
                    color: Theme.of(context).accentColor,
                  ),
                  onSelected: (value) {
                    model.sortingValue = value;
                    model.fetchAndSetClientJourneyRequests();
                  },
                  itemBuilder: (BuildContext context) => model.sortingCriteria
                      .map((e) => PopupMenuItem<String>(
                            value: e.value,
                            child: Row(
                              children: [Text(e.name), e.icon],
                            ),
                          ))
                      .toList()),
              PopupMenuButton<String>(
                  icon: Icon(
                    Icons.filter_list_outlined,
                    color: Theme.of(context).accentColor,
                  ),
                  onSelected: (value) {
                    model.filteringValue = value;
                    model.fetchAndSetClientJourneyRequests();
                  },
                  itemBuilder: (BuildContext context) => model.filteringCriteria
                      .map((e) => PopupMenuItem<String>(
                            value: e.value,
                            child: Text(e.name),
                          ))
                      .toList()),
            ],
          ),
          body: SafeArea(
              child: model.isBusy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : model.journeyRequests.isEmpty
                      ? Center(
                          child: Text(AppLocalizationDelegate
                              .appLocalizations!.clientJourneysEmptyText))
                      : ListView.builder(
                          controller: model.scrollController,
                          itemCount: model.journeyRequests.length,
                          itemBuilder: (ctx, index) {
                            return Card(
                                key: Key(
                                    model.journeyRequests[index].id.toString()),
                                //elevation: 8.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Stack(children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 15, top: 15, right: 15),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IntrinsicHeight(
                                                child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 3,
                                                    child: Column(children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5,
                                                                horizontal: 0),
                                                        child: Text(
                                                          model.dateFormatter!
                                                              .format(model
                                                                  .journeyRequests[
                                                                      index]
                                                                  .dateTime),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontSize: 17.0,
                                                              color: Colors
                                                                  .lightBlue,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline),
                                                        ),
                                                      ),
                                                    ])),
                                              ],
                                            )),
                                            Divider(
                                              indent: 5,
                                              endIndent: 5,
                                              thickness: 1.5,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            color: Colors.green,
                                                            size: 32,
                                                          ),
                                                          Text(
                                                            model
                                                                .journeyRequests[
                                                                    index]
                                                                .departurePlace
                                                                .name,
                                                            textAlign: TextAlign
                                                                .center,
                                                            softWrap: true,
                                                          )
                                                        ]),
                                                        Row(children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 14.0),
                                                            child: Container(
                                                              width: 4.0,
                                                              height: 50.0,
                                                              color: Colors
                                                                  .grey[350],
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          15.0),
                                                              child: Text(
                                                                '${model.journeyRequests[index].distance.toString()} Km',
                                                              )),
                                                        ]),
                                                        Row(children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            color: Colors.red,
                                                            size: 32,
                                                          ),
                                                          Text(
                                                            model
                                                                .journeyRequests[
                                                                    index]
                                                                .arrivalPlace
                                                                .name,
                                                            textAlign: TextAlign
                                                                .center,
                                                            softWrap: true,
                                                          )
                                                        ])
                                                      ]),
                                                  Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(children: [
                                                          Icon(
                                                            EngineTypeHelper
                                                                .getEngineTypeIconData(
                                                                    (model.journeyRequests[
                                                                            index])
                                                                        .engineType
                                                                        .code),
                                                            size: 32,
                                                            color: Colors
                                                                .lightBlue,
                                                          ),
                                                          Text(
                                                            model
                                                                .journeyRequests[
                                                                    index]
                                                                .engineType
                                                                .name,
                                                            softWrap: true,
                                                            textAlign: TextAlign
                                                                .center,
                                                          )
                                                        ]),
                                                        Column(
                                                          children: [
                                                            Icon(
                                                              Icons.person,
                                                              size: 32,
                                                              color: Colors
                                                                  .lightBlue,
                                                            ),
                                                            Text(
                                                              'X ${model.journeyRequests[index].workers}',
                                                              softWrap: true,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )
                                                          ],
                                                        )
                                                      ])
                                                ]),
                                            Divider(
                                              thickness: 1.5,
                                            ),
                                            ButtonBarTheme(
                                              data: ButtonBarThemeData(
                                                alignment: MainAxisAlignment
                                                    .spaceEvenly,
                                              ),
                                              child: IntrinsicHeight(
                                                  child: ButtonBar(
                                                layoutBehavior:
                                                    ButtonBarLayoutBehavior
                                                        .constrained,
                                                children: [
                                                  TextButton(
                                                      onPressed: () => model
                                                          .showDeleteJourneyWarning(
                                                              context,
                                                              model
                                                                  .journeyRequests[
                                                                      index]
                                                                  .id),
                                                      child: Tooltip(
                                                          message: MaterialLocalizations
                                                                  .of(context)
                                                              .deleteButtonTooltip,
                                                          child: Icon(
                                                            Icons.delete,
                                                            size: 32,
                                                          ))),
                                                  VerticalDivider(
                                                    indent: 5,
                                                    endIndent: 5,
                                                    thickness: 1.5,
                                                  ),
                                                  TextButton(
                                                      onPressed: () => model
                                                          .navigateToJourneyDetails(
                                                              index),
                                                      child: Tooltip(
                                                          message: AppLocalizations
                                                                  .of(context)!
                                                              .clientJourneysInfoTooltip,
                                                          child: Icon(
                                                            Icons.info,
                                                            size: 32,
                                                          ))),
                                                  VerticalDivider(
                                                    indent: 5,
                                                    endIndent: 5,
                                                    thickness: 1.5,
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        model
                                                            .navigateToJourneyProposals(
                                                                index);
                                                      },
                                                      child: Stack(children: <
                                                          Widget>[
                                                        Tooltip(
                                                            message: AppLocalizations
                                                                    .of(context)!
                                                                .clientJourneysProposalsTooltip,
                                                            child: Icon(
                                                              Icons
                                                                  .notifications,
                                                              size: 32,
                                                            )),
                                                        Positioned(
                                                          right: 0,
                                                          child: new Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    1),
                                                            decoration:
                                                                new BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            constraints:
                                                                BoxConstraints(
                                                              minWidth: 20,
                                                              minHeight: 20,
                                                            ),
                                                            child: new Text(
                                                              '${model.journeyRequests[index].proposalsCount}',
                                                              style:
                                                                  new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        )
                                                      ])),
                                                ],
                                              )),
                                            ),
                                          ])),
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 6),
                                      decoration: BoxDecoration(
                                          color: model.journeyRequests[index]
                                                  .dateTime
                                                  .isAfter(DateTime.now())
                                              ? Theme.of(context).accentColor
                                              : Colors.red,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          )),
                                      child: Text(
                                        model.journeyRequests[index].dateTime
                                                .isAfter(DateTime.now())
                                            ? AppLocalizations.of(context)!
                                                .clientJourneysOpened
                                            : AppLocalizations.of(context)!
                                                .clientJourneysExpired,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ]));
                          }))),
      viewModelBuilder: () => locator<JourneyRequestsViewModel>(),
    );
  }
}
