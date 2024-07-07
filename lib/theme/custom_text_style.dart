import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body style
  static get bodyLarge_1 => theme.textTheme.bodyLarge!;
  static get bodyMediumOnPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 14.fSize,
      );
  static get bodySmall9 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 9.fSize,
      );
  static get bodySmall9bold => theme.textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 11.fSize,
      );
// Title text style
  static get titleSmall14 => theme.textTheme.titleSmall!.copyWith(
        fontSize: 14.fSize,
      );
  static get bodyLargeLightblue700 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray400,
        fontSize: 16.fSize,
      );
  static get bodyLargeLightblue500 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.blueGray400,
        fontSize: 12.fSize,
      );
}
