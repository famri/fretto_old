import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/place_location.dart';
import 'package:fretto/ui/views/create_favorite_place/create_favorite_place_view.form.dart';
import 'package:fretto/ui/widgets/box_input_field.dart';
import 'package:fretto/ui/widgets/location_input.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'create_favorite_place_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'placeTitle'),
])
class CreateFavoritePlaceView extends StatelessWidget
    with $CreateFavoritePlaceView {
  CreateFavoritePlaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateFavoritePlaceViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
              AppLocalizations.of(context)!.addFavoriteLocationAppBarTitle),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      BoxInputField(
                        focusNode: placeTitleFocusNode,
                        placeholder: AppLocalizations.of(context)!
                            .addFavoriteLocationPlaceNameLabel,
                        controller: placeTitleController,
                        validator: (value) => value != null && value.isNotEmpty
                            ? null
                            : AppLocalizations.of(context)!
                                .addFavoriteLocationMissingPlaceName,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LocationInput(_selectPlace),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Container(
                    height: 50.0,
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        AppLocalizations.of(context)!.saveButtonText,
                      ),
                      onPressed: model.savePlace,
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide()))),
                    )))
          ],
        ),
      ),
      viewModelBuilder: () => CreateFavoritePlaceViewModel(),
    );
  }

  void _selectPlace(BuildContext context, CreateFavoritePlaceViewModel model,
      double lat, double lng) {
    model.updatePlaceLocation(PlaceLocation(latitude: lat, longitude: lng));
    FocusScope.of(context).requestFocus(placeTitleFocusNode);
  }
}
