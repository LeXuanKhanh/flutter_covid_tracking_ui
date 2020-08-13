import 'package:fluttercovidtrackingui/CustomWidget/ChartDetail.dart';

class CovidData {
  final total = 30000000;
  final recovered = 1500000;
  final death = 150000;
  final deathData = [
    ChartDetailData(0, DateTime.now().add(Duration(days: -4)), 1000),
    ChartDetailData(1, DateTime.now().add(Duration(days: -3)), 10000),
    ChartDetailData(2, DateTime.now().add(Duration(days: -2)), 200000),
    ChartDetailData(3, DateTime.now().add(Duration(days: -1)), 300000),
    ChartDetailData(4, DateTime.now(), 1500000),
  ];

  final recoveredData = [
    ChartDetailData(0, DateTime.now().add(Duration(days: -4)), 5000),
    ChartDetailData(1, DateTime.now().add(Duration(days: -3)), 15000),
    ChartDetailData(2, DateTime.now().add(Duration(days: -2)), 50000),
    ChartDetailData(3, DateTime.now().add(Duration(days: -1)), 100000),
    ChartDetailData(4, DateTime.now(), 150000),
  ];

  final mostCaseCountry = 'United States';
  final mostCaseTotal = 300000;
  final mostCaseRecovered = 150000;
  final mostCaseDeath = 1000;


}