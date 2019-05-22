library flutter_fab_loader;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'arc_painter.dart';

class FabLoadingWidget extends StatefulWidget {
  final Color color;
  final Widget child;
  final double strokeWidth;

  FabLoadingWidget(
      {this.strokeWidth = 8, this.color = Colors.orange, @required this.child});

  @override
  _FabLoadingWidget createState() =>
      new _FabLoadingWidget(strokeWidth: strokeWidth, child: child);
}

const BoxConstraints _sizeConstraints = BoxConstraints.tightFor(
  width: 56.0,
  height: 56.0,
);

const BoxConstraints _miniSizeConstraints = BoxConstraints.tightFor(
  width: 40.0,
  height: 40.0,
);

const BoxConstraints _extendedSizeConstraints = BoxConstraints(
  minHeight: 48.0,
  maxHeight: 48.0,
);

class _FabLoadingWidget extends State<FabLoadingWidget>
    with SingleTickerProviderStateMixin {
  final Widget child;
  final double strokeWidth;

  AnimationController controller;
  Animation animation;

  _FabLoadingWidget({@required this.strokeWidth, @required this.child});

  @override
  void initState() {
    // TODO: implement initState
    controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 10000))
      ..repeat();
    animation = Tween(begin: 0.0, end: 360.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = _sizeConstraints;
    return new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new CustomPaint(
          painter:
              new ArcPainter(progress: animation.value, color: widget.color),
          size: new Size(
              size.maxWidth + strokeWidth, size.maxHeight + strokeWidth),
        ),
        child
      ],
    );
  }
}
