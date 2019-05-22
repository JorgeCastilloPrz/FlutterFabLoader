library flutter_fab_loader;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'arc_painter.dart';

/// Draws a loading arc around the child view, supposed to be a
/// FloatingActionButton.
class FabLoader extends StatefulWidget {
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final double elevation;
  final bool mini;
  final BoxConstraints sizeConstraints;
  final Widget child;

  FabLoader({
    this.color = Colors.orange,
    this.backgroundColor = Colors.transparent,
    this.strokeWidth = 4,
    this.elevation = 6,
    @required this.child,
    this.mini = false,
  })  : assert(color != null),
        assert(backgroundColor != null),
        assert(strokeWidth != null),
        assert(elevation != null),
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

const ROTATE_ANIMATION_DURATION = 2000;

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
        vsync: this,
        duration: const Duration(milliseconds: ROTATE_ANIMATION_DURATION))
      ..repeat();

    var curve = new CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = Tween(begin: 0.0, end: 360.0).animate(curve);

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
        child,
        new CustomPaint(
          painter: new ArcPainter(
              strokeWidth: strokeWidth,
              progress: animation.value,
              backgroundColor: widget.backgroundColor,
              color: widget.color),
          size: new Size(
              size.maxWidth + strokeWidth, size.maxHeight + strokeWidth),
        ),
      ],
    );
  }
}
