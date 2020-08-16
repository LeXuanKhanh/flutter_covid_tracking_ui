import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttercovidtrackingui/CustomWidget/ChartDetail.dart';
import 'package:fluttercovidtrackingui/CustomWidget/DetailCase.dart';
import 'package:fluttercovidtrackingui/CustomWidget/MostCaseInfo.dart';
import 'package:fluttercovidtrackingui/CustomWidget/TotalCase.dart';
import 'package:fluttercovidtrackingui/Data/CovidData.dart';

import 'CustomWidget/LastedCase.dart';
import 'CustomWidget/VaccineStatus.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Covid Tracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Covid Tracking'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var color = Colors.white;
  final colors = List<Color>.filled(100, Colors.white);
  final heights = List<double>.filled(100, 0);
  final widths = List<double>.filled(100, 0);
  final _controller = ScrollController();
  CovidData data = CovidData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).accentColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView(
                  controller: _controller,
                  children: <Widget>[
                    TotalCase(count: data.total),
                    DetailCase(recovered: data.recovered, death: data.death),
                    ChartDetail(recoveredData: data.recoveredData, deathData: data.deathData),
                    MostCaseInfo(
                        mostCaseCountry: data.mostCaseCountry,
                        mostCaseTotal: data.mostCaseTotal,
                        mostCaseRecovered: data.mostCaseRecovered,
                        mostCaseDeath: data.mostCaseDeath,
                        mostCaseImage: data.mostCaseImage,
                    ),
                    LastedCase(
                        lastedCaseLocation: data. lastedCaseLocation,
                        lastedCaseFound: data.lastedCaseFound,
                        lastedCaseImage: data.lastedCaseImage,
                        lastedCaseImageCountry: data.lastedCaseImageCountry,
                    ),
                    VaccineStatus()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
