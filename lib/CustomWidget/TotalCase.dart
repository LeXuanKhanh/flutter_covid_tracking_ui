import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class TotalCase extends StatefulWidget {
  final int count;
  TotalCase({@required this.count});

  @override
  _TotalCaseState createState() => _TotalCaseState();
}

class _TotalCaseState extends State<TotalCase> {
  double _width = 0;
  double _height = 0;
  String content = "";
  double fontSize = 0;
  int duration = 0;
  double imgHeight = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction >= 0.5) {
      setState(() {
        _width = MediaQuery.of(context).size.width;
        _height = MediaQuery.of(context).size.height;
        fontSize = 32;
        duration = 500;
        imgHeight = 50;
      });
    } else {
      if (info.visibleFraction == 0) {
        _width = 0;
        _height = 0;
        fontSize = 0;
        duration = 0;
        imgHeight = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return VisibilityDetector(
      key: Key("TotalCase"),
      onVisibilityChanged: onVisibilityChanged,
      child: Container(
        height: 100,
        margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Center(
          child: AnimatedContainer(
            duration: Duration(milliseconds: duration),
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
            width: _width,
            height: _height,
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: duration),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    AnimatedContainer(
                        duration: Duration(milliseconds: duration),
                        height: imgHeight,
                        child: Image.asset("assets/coronavirus.gif")
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Text(
                            'Total',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        Text(
                            '3.000.000',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.normal)
                        ),
                      ],
                    ),
                    AnimatedContainer(
                        duration: Duration(milliseconds: duration),
                        height: imgHeight,
                        child: Image.asset("assets/coronavirus.gif")
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}