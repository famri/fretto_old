import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/geo_place_dto.dart';
import 'package:stacked/stacked.dart';

import 'favorite_places_viemodel.dart';

class FavoritePlacesView extends StatelessWidget {
  const FavoritePlacesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoritePlacesViewModel>.reactive(
      onModelReady: (model) => model.loadUserFavoritePlaces(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title:
                Text(AppLocalizations.of(context)!.favoritePlacesAppBarTitle),
            actions: [
              IconButton(
                onPressed: model.navigateToCreateFavoritePlace,
                tooltip: AppLocalizations.of(context)!.newTooltipText,
                icon: Container(
                    width: 50.0,
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).accentColor,
                    )),
              ),
            ],
          ),
          body: SafeArea(
              child: model.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : model.userFavoritePlaces.isEmpty
                      ? Center(
                          child: Text(AppLocalizations.of(context)!
                              .favoritePlacesEmptyText))
                      : SingleChildScrollView(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: model.userFavoritePlaces.length,
                              itemBuilder: (ctx, index) {
                                return GestureDetector(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.amber,
                                      ),
                                      Text(model.userFavoritePlaces[index].name)
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop<GeoPlaceDto>(
                                        model.userFavoritePlaces[index]);
                                  },
                                );
                              })))),
      viewModelBuilder: () => FavoritePlacesViewModel(),
    );
  }
}
