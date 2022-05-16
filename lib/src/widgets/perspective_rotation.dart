import 'package:flutter/material.dart';

class PerspectiveRotation extends StatefulWidget {
  const PerspectiveRotation({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<PerspectiveRotation> createState() => _PerspectiveRotationState();
}

class _PerspectiveRotationState extends State<PerspectiveRotation> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..rotateX(0.01 * _offset.dy)
        ..rotateY(-0.01 * _offset.dx),
      alignment: FractionalOffset.center,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _offset += details.delta;
          });
        },
        onDoubleTap: () {
          setState(() {
            _offset = Offset.zero;
          });
        },
        child: widget.child,
      ),
    );
  }
}
