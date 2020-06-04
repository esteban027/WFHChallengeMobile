/// Example of a time series chart with an end points domain axis.
///
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class EndPointsAxisTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final Color _orange = Color.fromRGBO(235, 89, 25, 1);

  EndPointsAxisTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  // factory EndPointsAxisTimeSeriesChart.withSampleData() {
  //   return new EndPointsAxisTimeSeriesChart(
  //     _createSampleData(),
  //     animate: true,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // return new charts.TimeSeriesChart(
    //   seriesList,
    //   animate: true,
    //   // Configures an axis spec that is configured to render one tick at each
    //   // end of the axis range, anchored "inside" the axis. The start tick label
    //   // will be left-aligned with its tick mark, and the end tick label will be
    //   // right-aligned with its tick mark.
    //   // domainAxis: new charts.EndPointsTimeAxisSpec(),
    //   animationDuration: Duration(seconds: 1),
    //   dateTimeFactory: const charts.LocalDateTimeFactory(),
    // );

    // return charts.TimeSeriesChart(
    //   seriesList,
    //   animate: true,
    //   behaviors: [
    //     // charts.RangeAnnotation([
    //     //   charts.LineAnnotationSegment(
    //     //     DateTime(2017, 10, 4), charts.RangeAnnotationAxisType.domain,
    //     //       startLabel: 'Oct 4'
    //     //   ),
    //     //   charts.LineAnnotationSegment(
    //     //     DateTime(2017, 10, 15), charts.RangeAnnotationAxisType.domain,
    //     //     endLabel: 'Oct 15'
    //     //   ),
    //     // ]),
    // ]
    // );

      return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Configure the default renderer as a line renderer. This will be used
      // for any series that does not define a rendererIdKey.
      //
      // This is the default configuration, but is shown here for  illustration.
      defaultRenderer: charts.LineRendererConfig(),
      // Custom renderer configuration for the point series.
      customSeriesRenderers: [
        charts.PointRendererConfig(
            // ID used to link series to this renderer.
            customRendererId: 'customPoint')
      ],
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final double sales;

  TimeSeriesSales(this.time, this.sales);
}