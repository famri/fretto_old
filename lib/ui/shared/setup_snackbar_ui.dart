import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

import 'snackbar_type.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();
  service.registerCustomSnackbarConfig(
    variant: SnackbarType.error,
    config: SnackbarConfig(
      backgroundColor: Colors.red[200]!,
      textColor: Colors.white,
      borderRadius: 1,
      // dismissDirection: SnackDismissDirection.HORIZONTAL,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.success,
    config: SnackbarConfig(
      backgroundColor: Colors.green[200]!,
      textColor: Colors.white,
      borderRadius: 1,
      //  dismissDirection: SnackDismissDirection.HORIZONTAL,
    ),
  );
}
