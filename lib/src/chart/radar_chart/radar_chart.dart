import 'package:fl_chart/src/chart/radar_chart/radar_chart_data.dart';
import 'package:fl_chart/src/chart/radar_chart/radar_chart_renderer.dart';
import 'package:flutter/material.dart';

/// Renders a radar chart as a widget, using provided [RadarChartData].
class RadarChart extends ImplicitlyAnimatedWidget {
  /// Determines how the [RadarChart] should be look like.
  final RadarChartData data;

  /// [data] determines how the [RadarChart] should be look like,
  /// when you make any change in the [RadarChart], it updates
  /// new values with animation, and duration is [swapAnimationDuration].
  const RadarChart(
    this.data, {
    Key? key,
    Duration swapAnimationDuration = const Duration(milliseconds: 150),
  }) : super(key: key, duration: swapAnimationDuration);

  @override
  _RadarChartState createState() => _RadarChartState();
}

class _RadarChartState extends AnimatedWidgetBaseState<RadarChart> {
  /// we handle under the hood animations (implicit animations) via this tween,
  /// it lerps between the old [RadarChartData] to the new one.
  RadarChartDataTween? _radarChartDataTween;

  @override
  Widget build(BuildContext context) {
    final showingData = _getDate();

    return RadarChartLeaf(
      data: _radarChartDataTween!.evaluate(animation),
      targetData: showingData,
      touchCallback: showingData.radarTouchData.touchCallback,
    );
  }

  RadarChartData _getDate() {
    return widget.data;
  }

  @override
  void forEachTween(visitor) {
    _radarChartDataTween = visitor(
      _radarChartDataTween,
      widget.data,
      (dynamic value) => RadarChartDataTween(begin: value, end: widget.data),
    ) as RadarChartDataTween;
  }
}
