/// Example of a time series chart with an end points domain axis.
///
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class EndPointsAxisTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final Color _orange = Color.fromRGBO(235, 89, 25, 1);

  EndPointsAxisTimeSeriesChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {

      return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.LineRendererConfig(),
      customSeriesRenderers: [
        charts.PointRendererConfig(
            customRendererId: 'customPoint'
        )
      ],
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      animationDuration: Duration(seconds: 1),
    );
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final double sales;

  TimeSeriesSales(this.time, this.sales);
}