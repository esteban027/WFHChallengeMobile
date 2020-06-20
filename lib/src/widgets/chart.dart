import 'package:WFHchallenge/src/models/ratings_page_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TimeSeriesSales {
  final DateTime time;
  final double sales;

  TimeSeriesSales(this.time, this.sales);
}

class LineChartSample1 extends StatefulWidget {
  final RatingsPageModel ratings;

  LineChartSample1(this.ratings);

  @override
  State<StatefulWidget> createState() => LineChartSample1State(ratings);
}

class LineChartSample1State extends State<LineChartSample1> {
  bool isShowingMainData;
  RatingsPageModel ratings;
  double minYear;
  double maxYear;
  Color _darkBlue = Color.fromRGBO(22, 25, 29, 1);
  Color _blue = Color.fromRGBO(28, 31, 44, 1);
  Color _orange = Color.fromRGBO(235, 89, 25, 1);
  LineChartSample1State(this.ratings);

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
      _timeStampsToDates(ratings);

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
                      createLineChartData(minsX[graphNumber], maxsX[graphNumber]),
                      swapAnimationDuration: const Duration(milliseconds: 500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.navigate_next,
                  color: Colors.white.withOpacity(spotsList.length == 1 ? 0 : 1),
                ),
                onPressed: () {
                  setState(() {
                    if (graphNumber == spotsList.length){
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
      dateList.sort((a, b) => a.compareTo(b));
      minsX.add(dateList.first.toDouble());
      maxsX.add(dateList.last.toDouble());
    });
  }

 void _timeStampsToDates(RatingsPageModel ratings) {
    List<DateTime> dates = [];
    List<FlSpot> spots = [];
    int counter = 0;
        
    List<FlSpot> temporalSpots = [];
    List<int> temporalYearDate = [];

    ratings.items.forEach((rating) {
      dates.add(DateTime.fromMillisecondsSinceEpoch(rating.timestamp * 1000));
    });

    dates.forEach((date) {
      int year = date.year.toInt();
      double rating = ratings.items[counter].rating;
      FlSpot spot = FlSpot(year.toDouble(), rating);
      spots.add(spot);
      counter++;
    });

    // datelist 

    if (dates.length > 5) {
      counter = 0;
      dates.forEach((date) {
        counter++;
        temporalYearDate.add(date.year);
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
    spotsList.add(temporalSpots);
    } else {
      spotsList.add(spots);
    }

  }

  List<LineChartBarData> createLinebarData(int number) {
    final LineChartBarData lineChartBarData = LineChartBarData(
      spots: spotsList[graphNumber],
      isCurved: false,
      colors: [
        _orange
      ],
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
