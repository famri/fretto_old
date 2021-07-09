import 'package:flutter/material.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:fretto/models/place_location.dart';
import 'package:fretto/ui/shared/colors.dart';
import 'package:fretto/ui/shared/ui_helpers.dart';
import 'package:fretto/ui/widgets/box_button.dart';
import 'package:fretto/utils/location_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function(double latitude, double longitude) onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Location location = new Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;

  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled!) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled!) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      LocationData? locData = await location.getLocation();
      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPlace(locData.latitude!, locData.longitude!);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final locData = await Location().getLocation();
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          initialLocation: PlaceLocation(
              latitude: locData.latitude!, longitude: locData.longitude!),
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  AppLocalizations.of(context)!
                      .addFavoriteLocationChoosePlaceText,
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        verticalSpaceMedium,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            BoxButton.outline(
              title: AppLocalizations.of(context)!
                  .addFavoriteLocationMyPositionText,
              leading: Icon(
                Icons.location_on,
                color: kcPrimaryColor,
              ),
              onTap: _getCurrentUserLocation,
            ),
            verticalSpaceMedium,
            BoxButton.outline(
              title: AppLocalizations.of(context)!
                  .addFavoriteLocationLocateOnMapText,
              leading: Icon(
                Icons.map,
                color: kcPrimaryColor,
              ),
              onTap: _selectOnMap,
            )
          ],
        ),
      ],
    );
  }
}
