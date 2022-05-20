import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomIcons {
  CustomIcons._();

  static const IconData about = FeatherIcons.info;
  static const IconData back = FeatherIcons.arrowLeft;
  static const IconData lightTheme = FeatherIcons.sun;
  static const IconData darkTheme = FeatherIcons.moon;
  static const IconData chevronLeft = FeatherIcons.chevronLeft;
  static const IconData chevronRight = FeatherIcons.chevronRight;
  static const IconData text = FeatherIcons.type;
  static const IconData code = FeatherIcons.code;
  static const IconData play = FeatherIcons.play;
  static const IconData stop = FeatherIcons.pause;
  static const IconData copy = FeatherIcons.copy;
  static const IconData paste = FeatherIcons.clipboard;
  static const IconData clear = FeatherIcons.x;
  static const IconData share = FeatherIcons.share2;

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
