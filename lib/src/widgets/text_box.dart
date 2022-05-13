import 'dart:ui';

import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox({
    Key? key,
    this.keyboardType,
    required this.controller,
    required this.prefixIconData,
    required this.hintText,
    required this.focusNode,
    required this.onFocusChange,
    required this.onValueChange,
    required this.actions,
  }) : super(key: key);

  final IconData prefixIconData;
  final String hintText;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(bool) onFocusChange;
  final void Function(String) onValueChange;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        height: 140,
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
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
                    prefixIcon: Icon(
                      prefixIconData,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  focusNode: focusNode,
                  controller: controller,
                  onChanged: onValueChange,
                ),
                onFocusChange: onFocusChange,
              ),
            ),
            Row(
              children: actions,
            ),
          ],
        ),
      ),
    );
  }
}
