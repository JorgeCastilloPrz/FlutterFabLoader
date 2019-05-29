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
  final Widget child;

  FabLoader({
    this.color = Colors.orange,
    this.backgroundColor = Colors.transparent,
    this.strokeWidth = 4,
    @required this.child,
  })  : assert(color != null),
        assert(backgroundColor != null),
        assert(strokeWidth != null),
        assert(child != null);

  @override
  _FabLoadingWidget createState() =>
      new _FabLoadingWidget(strokeWidth: strokeWidth, child: child);
}

// Arc head will be lead by this Tween curve.
final Animatable<double> _kStrokeHeadTween = CurveTween(
  curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
).chain(CurveTween(
  curve: const SawTooth(5),
));

// Arc tail will be lead by this Tween curve.
final Animatable<double> _kStrokeTailTween = CurveTween(
  curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
).chain(CurveTween(
  curve: const SawTooth(5),
));

// The current progress step will be lead by this stepped Tween.
final Animatable<int> _kStepTween = StepTween(begin: 0, end: 5);

// The rotation for the arc as a whole will be lead by this Tween curve.
final Animatable<double> _kRotationTween = CurveTween(curve: const SawTooth(5));

class _FabLoadingWidget extends State<FabLoader>
    with SingleTickerProviderStateMixin {
  final Widget child;
  final double strokeWidth;

  AnimationController _controller;

  _FabLoadingWidget({@required this.strokeWidth, @required this.child});

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _controller.repeat(); // we want it to repeat over and over (indeterminate)
  }

  @override
  void didUpdateWidget(FabLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    // We want to start animation again if the widget is updated.
    if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // avoid leaks
    super.dispose();
  }

  Widget _buildIndicator(
      double headValue, double tailValue, int stepValue, double rotationValue) {
    return new CustomPaint(
      child: child,
      foregroundPainter: new ArcPainter(
          strokeWidth: strokeWidth,
          backgroundColor: widget.backgroundColor,
          valueColor: widget.color,
          headValue: headValue,
          tailValue: tailValue,
          stepValue: stepValue,
          rotationValue: rotationValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return _buildIndicator(
          _kStrokeHeadTween.evaluate(_controller),
          _kStrokeTailTween.evaluate(_controller),
          _kStepTween.evaluate(_controller),
          _kRotationTween.evaluate(_controller),
        );
      },
    );
  }
}
