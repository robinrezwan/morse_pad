import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomIcons {
  CustomIcons._();

  static const IconData about = Feather.info;
  static const IconData back = Feather.arrow_left;
  static const IconData lightTheme = Feather.sun;
  static const IconData darkTheme = Feather.moon;
  static const IconData chevronLeft = Feather.chevron_left;
  static const IconData chevronRight = Feather.chevron_right;
  static const IconData text = Feather.type;
  static const IconData code = Feather.code;
  static const IconData play = Feather.play;
  static const IconData stop = Feather.pause;
  static const IconData copy = Feather.copy;
  static const IconData paste = Feather.clipboard;
  static const IconData clear = Feather.x;
  static const IconData share = Feather.share_2;

  static const IconData backspace = Icons.backspace_outlined;
  static const IconData enter = Icons.keyboard_return;
  static const IconData keyboardHide = Icons.keyboard_hide_outlined;
  static const IconData forwardSlash = MdiIcons.slashForward;
  static const IconData chevronBack = Icons.chevron_left;
  static const IconData chevronForward = Icons.chevron_right;
  static const IconData chevronDoubleBack = MdiIcons.chevronDoubleLeft;
  static const IconData arrowDoubleForward = MdiIcons.chevronDoubleRight;
  static const IconData chevronBackEnd = MdiIcons.pageFirst;
  static const IconData chevronForwardEnd = MdiIcons.pageLast;

  static const IconData systemTheme =
      IconData(0xe800, fontFamily: 'CustomIcons');
}
