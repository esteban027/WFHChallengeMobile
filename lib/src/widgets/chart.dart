import 'package:WFHchallenge/src/models/ratings_page_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TimeSeriesSales {
  final DateTime time;
  final double sales;

  TimeSeriesSales(this.time, this.sales);
}

class LineChartSample1 extends StatefulWidget {
  final List<GraphicRating> ratings;

  LineChartSample1(this.ratings);

  @override
  State<StatefulWidget> createState() => LineChartSample1State(ratings);
}

class LineChartSample1State extends State<LineChartSample1> {
  bool isShowingMainData;
  List<GraphicRating> ratingsList;
  double minYear;
  double maxYear;
  Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  Color _blue = Color.fromRGBO(28, 31, 44, 1);
  Color _orange = Color.fromRGBO(235, 89, 25, 1);
  LineChartSample1State(this.ratingsList);
  List<double> intervals = [];

  List<List<FlSpot>> spotsList = [];
  List<List<int>> datesList = [];

  List<double> minsX = [];
  List<double> maxsX = [];

  int graphNumber = 0;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    _timeStampsToDates();

    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      createLineChartData(
                          minsX[graphNumber], maxsX[graphNumber]),
                      swapAnimationDuration: const Duration(milliseconds: 500),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.navigate_next,
                  color:
                      Colors.white.withOpacity(spotsList.length == 1 ? 0 : 1),
                ),
                onPressed: () {
                  setState(() {
                    if (graphNumber == spotsList.length - 1) {
                      graphNumber = 0;
                    } else {
                      graphNumber++;
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void maxAndMin() {
    datesList.forEach((dateList) {
      if (dateList.length > 1) {
        dateList.sort((a, b) => a.compareTo(b));
        minsX.add(dateList.first.toDouble());
        maxsX.add(dateList.last.toDouble());
      }
    });
  }

  void _timeStampsToDates() {
    List<DateTime> dates = [];
    List<int> years = [];
    List<FlSpot> spots = [];
    int counter = 0;
    spotsList = [];
    intervals = [];
    datesList = [];

    List<int> temporalYearDate = [];

    ratingsList.forEach((rating) {
      years.add(rating.year);
    });

    for (int i = 0; i< ratingsList.length; i++) {
      FlSpot spot = FlSpot(ratingsList[i].year.toDouble(), ratingsList[i].rating);
      years.add(ratingsList[i].year);
      spots.add(spot);
    }

    // datelist
    if (years.length > 5) {
      counter = 0;
      years.forEach((year) {
        counter++;
        temporalYearDate.add(year);
        if (counter == 5) {
          counter = 0;
          datesList.add(temporalYearDate);
          temporalYearDate = [];
        }
      });
      datesList.add(temporalYearDate);
    } else {
      dates.forEach((date) {
        temporalYearDate.add(date.year);
      });
      datesList.add(temporalYearDate);
    }

    maxAndMin();

    if (spots.length > 5) {
      List<FlSpot> temporalSpots = [];
      counter = 0;
      spots.forEach((spot) {
        counter++;
        temporalSpots.add(spot);
        if (counter == 5) {
          counter = 0;
          spotsList.add(temporalSpots);
          temporalSpots = [];
        }
      });

      bool isdividedBy5 = (spots.length ~/ 5) is int;
      if (!isdividedBy5) {
        spotsList.add(temporalSpots);
      }
    } else {
      spotsList.add(spots);
    }

    spotsList.forEach((spot) {
      if (spot.length > 1) {
        double diferenceYears = spot.last.x - spot.first.x;
        bool diferenceIsInt = (diferenceYears / 5) is int;
        if (diferenceYears == 0 && diferenceYears < 5) {
          diferenceYears = 1;
        } else if (!diferenceIsInt) {
          diferenceYears = (diferenceYears ~/ 5).toDouble() + 1;
        }
        intervals.add(diferenceYears);
      } else {
        intervals.add(1);
      }
    });
  }

  List<LineChartBarData> createLinebarData(int number) {
    final LineChartBarData lineChartBarData = LineChartBarData(
      spots: spotsList[graphNumber],
      isCurved: false,
      colors: [_orange],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    return [
      lineChartBarData,
    ];
  }

  LineChartData createLineChartData(double minx, double maxx) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
          margin: 10,
          getTitles: (value) {
            return value.toString();
          },
          interval: intervals[graphNumber],
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            return value.toString();
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),

      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: minx,
      maxX: maxx,
      maxY: 5,
      minY: 0,
      lineBarsData: createLinebarData(0),
    );
  }
}
