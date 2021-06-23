import 'package:flutter/material.dart';
import 'package:fretto/ui/shared/colors.dart';
import 'package:fretto/ui/shared/styles.dart';

class BoxText extends StatelessWidget {
  final String text;
  final TextStyle style;

  BoxText.headingOne(this.text, {Color color = kcPetroliumBlue})
      : style = heading1Style.copyWith(color: color);
  BoxText.headingTwo(this.text, {Color color = kcPetroliumBlue})
      : style = heading2Style.copyWith(color: color);
  BoxText.headingThree(this.text, {Color color = kcPetroliumBlue})
      : style = heading3Style.copyWith(color: color);
  BoxText.headline(this.text, {Color color = kcPetroliumBlue})
      : style = headlineStyle.copyWith(color: color);
  BoxText.subheading(this.text, {Color color = kcPetroliumBlue})
      : style = subheadingStyle.copyWith(color: color);
  BoxText.caption(this.text, {Color color = kcPetroliumBlue})
      : style = captionStyle.copyWith(color: color);

  BoxText.body(this.text, {Color color = kcPetroliumBlue})
      : style = bodyStyle.copyWith(color: color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
