import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/ui/shared/ui_helpers.dart';
import 'package:fretto/ui/widgets/box_button.dart';
import 'package:fretto/ui/widgets/box_input_field.dart';
import 'package:fretto/ui/widgets/location_input.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'create_favorite_place_view.form.dart';
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
      onModelReady: (model) => listenToFormUpdated(model),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
              AppLocalizations.of(context)!.addFavoriteLocationAppBarTitle),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              children: <Widget>[
                Form(
                  key: model.formKey,
                  child: BoxInputField(
                    focusNode: placeTitleFocusNode,
                    placeholder: AppLocalizations.of(context)!
                        .addFavoriteLocationPlaceNameLabel,
                    controller: placeTitleController,
                    textInputAction: TextInputAction.done,
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : AppLocalizations.of(context)!
                            .addFavoriteLocationMissingPlaceName,
                  ),
                ),
                verticalSpaceMedium,
                LocationInput(model.selectPlace),
                verticalSpaceMedium,
                if (model.hasErrorForKey(model.placeSelection))
                  Text(model.error(model.placeSelection),
                      style: TextStyle(color: Colors.red)),
                verticalSpaceMedium,
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                  child: !model.isBusy
                      ? BoxButton(
                          title: AppLocalizations.of(context)!.saveButtonText,
                          onTap: model.runBusySaveFavoritePlace)
                      : BoxButton(
                          busy: true,
                          title: AppLocalizations.of(context)!.saveButtonText,
                          onTap: () {}),
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CreateFavoritePlaceViewModel(),
    );
  }
}
