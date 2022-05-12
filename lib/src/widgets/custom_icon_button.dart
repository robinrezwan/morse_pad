import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final String tooltip;
  final void Function() onPressed;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.tooltip, // TODO: 5/6/2021 Make tooltip optional
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      radius: 20,
      child: Tooltip(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: icon,
        ),
        message: tooltip,
      ),
      onTap: onPressed,
    );
  }
}
