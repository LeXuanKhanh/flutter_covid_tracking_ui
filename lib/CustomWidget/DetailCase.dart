import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:fluttercovidtrackingui/Extension/IntExtension.dart';

class DetailCase extends StatefulWidget {
  final int recovered;
  final int death;

  DetailCase({@required this.recovered, @required this.death});

  @override
  _DetailCaseState createState() => _DetailCaseState();
}

class _DetailCaseState extends State<DetailCase> {
  List<double> _heights = List<double>.filled(2, 0);

  List<int> countsMax; // MARK: modified once in initState
  List<String> _count = List<String>.filled(2, '');
  List<bool> _countIsHidden = List<bool>.filled(2, true);

  double fontSize = 28;
  int duration = 0;

  void synchronousAnimation() async {
    for (var i = 0; i < 2; i++) {
      await new Future.delayed(const Duration(milliseconds: 300));

      if (context != null) {
        setState(() {
          _heights[i] = 200;
          if (_countIsHidden[i]) {
            _countIsHidden[i] = false;
            _count[i] = '';
          }
        });
      }
      await new Future.delayed(const Duration(milliseconds: 500));

      if (context != null) {
        setState(() {
          _count[i] = countsMax[i].toStringWithFormat();
        });
      }
    }
  }

  void onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction >= 0.5) {
      setState(() {
        duration = 500;
        synchronousAnimation();
      });
    } else {
      if (info.visibleFraction == 0) {
        if (context != null) {
          setState(() {
            _heights.fillRange(0, 2, 0);
            _countIsHidden.fillRange(0, 2, true);
            duration = 0;
          });
        }
      }
    }
  }

  Widget DetailCaseTile(
      {Color color, double height, String content, String count}) {
    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: duration),
        height: height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(8, 8),
                spreadRadius: 0,
                blurRadius: 10,
              )
            ]),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Text(content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold)),
              Text(count,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countsMax = [widget.recovered, widget.death];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return VisibilityDetector(
      key: Key("DetailCase"),
      onVisibilityChanged: onVisibilityChanged,
      child: Container(
        height: 100,
        margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DetailCaseTile(
                color: Colors.green,
                height: _heights[0],
                content: 'Recovered',
                count: _count[0]),
            SizedBox(width: 8),
            DetailCaseTile(
                color: Colors.red,
                height: _heights[1],
                content: 'Death',
                count: _count[1]),
          ],
        ),
      ),
    );
  }
}
