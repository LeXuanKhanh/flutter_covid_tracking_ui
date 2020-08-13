import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttercovidtrackingui/CustomWidget/ChartDetail.dart';
import 'package:fluttercovidtrackingui/CustomWidget/DefaultContainer.dart';
import 'package:fluttercovidtrackingui/CustomWidget/DetailCase.dart';
import 'package:fluttercovidtrackingui/CustomWidget/MostCaseInfo.dart';
import 'package:fluttercovidtrackingui/CustomWidget/TotalCase.dart';
import 'package:fluttercovidtrackingui/Data/CovidData.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'CustomWidget/LastedCase.dart';

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
  int _counter = 0;
  var color = Colors.white;
  final colors = List<Color>.filled(100, Colors.white);
  final heights = List<double>.filled(100, 0);
  final widths = List<double>.filled(100, 0);
  final _controller = ScrollController();
  CovidData data = CovidData();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView(
                controller: _controller,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.display1,
                  ),
                  TotalCase(count: data.total),
                  DetailCase(recovered: data.recovered, death: data.death),
                  ChartDetail(recoveredData: data.recoveredData, deathData: data.deathData),
                  MostCaseInfo(
                      mostCaseCountry: data.mostCaseCountry,
                      mostCaseTotal: data.mostCaseTotal,
                      mostCaseRecovered: data.mostCaseRecovered,
                      mostCaseDeath: data.mostCaseDeath
                  ),
                  LastedCase(
                      mostCaseCountry: data.mostCaseCountry,
                      mostCaseTotal: data.mostCaseTotal,
                      mostCaseRecovered: data.mostCaseRecovered,
                      mostCaseDeath: data.mostCaseDeath
                  ),
                  for (var i = 0; i < 20; i++)
                    VisibilityDetector(
                      key: Key("key$i"),
                      onVisibilityChanged: (visibilityInfo) {

                        if (visibilityInfo.visibleFraction >= 0.5 || (_controller.position.userScrollDirection == ScrollDirection.forward)) {
                          setState(() {
                            colors[i] = Colors.red;
                            heights[i] = 50;
                            widths[i] = 1000;
                          });
                        } else {
                          if (visibilityInfo.visibleFraction == 0) {
                            setState(() {
                              colors[i] = Colors.white;
                              heights[i] = 0;
                              widths[i] = 0;
                            });
                          }

                        }

                      },
                      child: DefaultContainer(
                          height: 100,
                          color: colors[i],
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            clipBehavior: Clip.hardEdge,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: AnimatedContainer(
                                height: heights[i],
                                width: widths[i],
                                duration: Duration(milliseconds: 800),
                                color: Colors.black,
                              ),
                            ),
                          ),
                      )
                    ),

                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
