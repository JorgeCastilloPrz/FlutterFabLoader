library flutter_fab_loader;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'arc_painter.dart';

class FabLoader extends StatefulWidget {
  final Color color;
  final Widget child;
  final double strokeWidth;
  final bool mini;
  final BoxConstraints sizeConstraints;

  FabLoader({
    this.strokeWidth = 4,
    this.color = Colors.orange,
    @required this.child,
    this.mini = false,
  })  : assert(strokeWidth != null),
        assert(color != null),
        assert(child != null),
        assert(mini != null),
        sizeConstraints = mini ? _miniSizeConstraints : _defaultSizeConstraints;

  @override
  _FabLoadingWidget createState() => new _FabLoadingWidget(
      sizeConstraints: sizeConstraints, strokeWidth: strokeWidth, child: child);
}

const BoxConstraints _defaultSizeConstraints = BoxConstraints.tightFor(
  width: 56.0,
  height: 56.0,
);

const BoxConstraints _miniSizeConstraints = BoxConstraints.tightFor(
  width: 40.0,
  height: 40.0,
);

class _FabLoadingWidget extends State<FabLoader>
    with SingleTickerProviderStateMixin {
  final Widget child;
  final double strokeWidth;
  final BoxConstraints sizeConstraints;

  AnimationController controller;
  Animation animation;

  _FabLoadingWidget(
      {@required this.sizeConstraints,
      @required this.strokeWidth,
      @required this.child});

  @override
  void initState() {
    super.initState();
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
    var size = sizeConstraints;
    return new Stack(
      alignment: Alignment.center,
      children: <Widget>[
        new CustomPaint(
          painter: new ArcPainter(
              strokeWidth: strokeWidth,
              progress: animation.value,
              color: widget.color),
          size: new Size(
              size.maxWidth + strokeWidth, size.maxHeight + strokeWidth),
        ),
        child
      ],
    );
  }
}
