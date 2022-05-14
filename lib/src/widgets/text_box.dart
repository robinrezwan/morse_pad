import 'dart:ui';

import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox({
    Key? key,
    this.keyboardType,
    required this.controller,
    required this.prefixIcon,
    required this.hintText,
    required this.focusNode,
    required this.onFocusChange,
    required this.onValueChange,
    required this.onTap,
    required this.actions,
  }) : super(key: key);

  final Widget prefixIcon;
  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(bool) onFocusChange;
  final void Function(String) onValueChange;
  final void Function() onTap;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: SizedBox(
        height: 160,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(6, 8, 6, 0),
                child: Focus(
                  child: TextField(
                    scrollPhysics: const BouncingScrollPhysics(),
                    keyboardType: keyboardType,
                    maxLines: null,
                    style: const TextStyle(
                      fontFamily: 'JetBrains Mono',
                      fontFeatures: [
                        FontFeature.disable('calt'),
                        FontFeature.disable('clig'),
                      ],
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText,
                      prefixIcon: Container(
                        padding: const EdgeInsets.only(top: 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconTheme(
                              data: Theme.of(context).iconTheme,
                              child: prefixIcon,
                            ),
                          ],
                        ),
                      ),
                    ),
                    focusNode: focusNode,
                    controller: controller,
                    onChanged: onValueChange,
                    onTap: onTap,
                  ),
                  onFocusChange: onFocusChange,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Row(
                children: actions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
