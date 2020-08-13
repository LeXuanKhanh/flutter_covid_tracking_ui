import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fluttercovidtrackingui/Extension/DateTimeExtension.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ChartDetailData {
  final index;
  final DateTime date;
  final int cases;

  ChartDetailData(this.index, this.date, this.cases);
}

class ChartDetail extends StatefulWidget {
  final List<ChartDetailData> deathData;
  final List<ChartDetailData> recoveredData;

  ChartDetail({@required this.recoveredData, @required this.deathData});

  @override
  _ChartDetailState createState() => _ChartDetailState();
}

class _ChartDetailState extends State<ChartDetail> {
  List<charts.Series> seriesList;
  bool animate;
  bool isHidden = true;
  int duration = 500;

  List<charts.Series<ChartDetailData, DateTime>> _createSampleData() {
    return [
      new charts.Series<ChartDetailData, DateTime>(
        id: 'deathData',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (ChartDetailData data, _) => data.date,
        measureFn: (ChartDetailData data, _) => data.cases,
        data: widget.deathData,
      ),
      new charts.Series<ChartDetailData, DateTime>(
        id: 'RecoverData',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (ChartDetailData data, _) => data.date,
        measureFn: (ChartDetailData data, _) => data.cases,
        data: widget.recoveredData,
      ),
    ];
  }

  void onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction >= 0.5) {
      setState(() {
        duration = 500;
        isHidden = false;
      });
    } else {
      if (info.visibleFraction == 0) {
        setState(() {
          duration = 0;
          isHidden = true;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seriesList = _createSampleData();
    animate = true;
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("MostCaseInfo"),
      onVisibilityChanged: onVisibilityChanged,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: duration),
        opacity: isHidden ? 0 : 1,
        child: Container(
            height: 300,
            margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
            padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
            decoration: BoxDecoration(
                border: Border.all(width: 0.3),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(8, 8),
                    spreadRadius: 0,
                    blurRadius: 10,
                  )
                ]),
            child: charts.TimeSeriesChart(
              seriesList,
              animate: animate,
              dateTimeFactory: charts.LocalDateTimeFactory(),
            )),
      ),
    );
  }
}
