import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/ui/shared/colors.dart';
import 'package:fretto/ui/shared/styles.dart';
import 'package:fretto/ui/shared/ui_helpers.dart';
import 'package:fretto/ui/widgets/box_button.dart';
import 'package:stacked_services/stacked_services.dart';

import 'bottom_sheet_type.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.FLOATING_BOX: (context, sheetRequest, completer) =>
        _FloatingBoxBottomSheet(request: sheetRequest, completer: completer)
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

class _FloatingBoxBottomSheet extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;
  const _FloatingBoxBottomSheet({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.all(25),
      
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      child: Column(
        children: [
          if (request!.title != null)
            Text(
              request!.title!,
              style: headlineStyle.copyWith(color: kcPetroliumBlue),
            ),
          verticalSpaceTiny,
          if (request!.description != null)
            Text(
              request!.description!,
              style: heading3Style.copyWith(color: kcPetroliumBlue),
            ),
          verticalSpaceTiny,
          if (request!.mainButtonTitle != null &&
              request!.secondaryButtonTitle != null)
            BoxButton(
              title: request!.mainButtonTitle!,
              onTap: () => completer!(SheetResponse(confirmed: false)),
            ),
          verticalSpaceTiny,
          if (request!.mainButtonTitle != null &&
              request!.secondaryButtonTitle != null)
            BoxButton(
                title: request!.secondaryButtonTitle!,
                onTap: () => completer!(SheetResponse(confirmed: true)))
        ],
      ),
    );
  }
}
