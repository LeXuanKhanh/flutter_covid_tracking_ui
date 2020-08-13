import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LastedCase extends StatefulWidget {
  final String mostCaseCountry;
  final int mostCaseTotal;
  final int mostCaseRecovered;
  final int mostCaseDeath;

  LastedCase(
      {@required this.mostCaseCountry,
      @required this.mostCaseTotal,
      @required this.mostCaseRecovered,
      @required this.mostCaseDeath});

  @override
  _LastedCaseState createState() => _LastedCaseState();
}

class _LastedCaseState extends State<LastedCase> {
  bool isHidden = true;
  int duration = 500;

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
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("LastedCase"),
      onVisibilityChanged: onVisibilityChanged,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: duration),
        opacity: isHidden ? 0 : 1,
        child: Container(
          margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
          height: 400,
          child: Center(
            child: AnimatedContainer(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                duration: Duration(milliseconds: 500),
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
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.red,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Image.asset(
                          "assets/da_nang2.jpg",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          padding: EdgeInsets.all(16),
                          decoration:
                              BoxDecoration(
                                  color: Colors.transparent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(0, 0),
                                      spreadRadius: 6,
                                      blurRadius: 90,
                                    )
                                  ]
                              ),
                          child: Text(
                            'Cases Found: 15',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                          decoration:
                              BoxDecoration(color: Colors.transparent, boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0),
                                  spreadRadius: 6,
                                  blurRadius: 90,
                                )
                          ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Lasted Case',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white
                                    ),
                                  ),
                                  Text(
                                    'Da Nang, Viet Nam',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                                child: Image.asset("assets/viet_nam.png", fit: BoxFit.fitWidth),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
