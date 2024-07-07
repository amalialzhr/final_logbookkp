import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );
// Outline decorations
  static BoxDecoration get outlineGray => BoxDecoration(
        border: Border.all(
          color: appTheme.gray500,
          width: 1.h,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      );
  static BoxDecoration get outlineGray400 => BoxDecoration(
        color: appTheme.gray400,
        border: Border.all(
          color: appTheme.gray400,
          width: 1.h,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      );
  static BoxDecoration get outlineGray500 => BoxDecoration(
        color: appTheme.gray400,
        border: Border.all(
          color: appTheme.gray500,
          width: 1.h,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      );
  static BoxDecoration get outlineOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        border: Border.all(
          color: theme.colorScheme.onPrimary,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              2,
              4,
            ),
          )
        ],
      );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder5 => BorderRadius.circular(
        5.h,
      );
}
