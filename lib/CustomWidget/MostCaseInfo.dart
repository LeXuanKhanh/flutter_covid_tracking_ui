import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:fluttercovidtrackingui/Extension/IntExtension.dart';

class MostCaseInfo extends StatefulWidget {

  final String mostCaseCountry;
  final int mostCaseTotal;
  final int mostCaseRecovered;
  final int mostCaseDeath;
  final String mostCaseImage;

  MostCaseInfo({
    @required this.mostCaseCountry,
    @required this.mostCaseTotal,
    @required this.mostCaseRecovered,
    @required this.mostCaseDeath,
    @required this.mostCaseImage,
  });

  @override
  _MostCaseInfoState createState() => _MostCaseInfoState();
}

class _MostCaseInfoState extends State<MostCaseInfo> {
  List<int> countsMax; // MARK: modified once in initState
  List<int> counts = [0, 0, 0];

  double opacity = 0;

  int durationOpacity = 0;
  int durationCount = 0;

  void onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction >= 0.5) {
      setState(() {
        delayAnimation();
        opacity = 1;
        durationOpacity = 500;
      });
    } else {
      if (info.visibleFraction == 0) {
        setState(() {
          counts.fillRange(0, 3, 0);
          opacity = 0;
          durationCount = 0;
          durationOpacity = 0;
        });
      }
    }
  }

  void delayAnimation() async {
    await new Future.delayed(Duration(milliseconds: 300));
    if (context !=  null) {
      setState(() {
        for (var i = 0; i < 3; i ++) {
          counts[i] = countsMax[i];
        }
        durationCount = 1;
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countsMax = [widget.mostCaseTotal, widget.mostCaseRecovered, widget.mostCaseDeath];
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("MostCaseInfo"),
      onVisibilityChanged: onVisibilityChanged,
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Center(
          child: AnimatedContainer(
              padding: EdgeInsets.all(16),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 8),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: durationOpacity),
                    opacity: opacity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(widget.mostCaseImage, height: 50),
                        SizedBox(width: 8),
                        Text(widget.mostCaseCountry, style: TextStyle(fontSize: 32)),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  DefaultTextStyle(
                    style: TextStyle(fontSize: 25),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('Total',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold)),
                            AnimatedCount(
                                count: counts[0],
                                duration: Duration(seconds: durationCount),
                                style: TextStyle(color: Colors.black54)
                            )
                          ],
                        ),
                        SizedBox(width: 16),
                        Column(
                          children: <Widget>[
                            Text('Recovered',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold)),
                            AnimatedCount(
                                count: counts[1],
                                duration: Duration(seconds: durationCount),
                                style: TextStyle(color: Colors.green)
                            )
                          ],
                        ),
                        SizedBox(width: 16),
                        Column(
                          children: <Widget>[
                            Text('Death',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                            AnimatedCount(
                                count: counts[2],
                                duration: Duration(seconds: durationCount),
                                style: TextStyle(color: Colors.red)
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class AnimatedCount extends ImplicitlyAnimatedWidget {
  final int count;
  final TextStyle style;

  AnimatedCount(
      {Key key,
      @required this.count,
      @required Duration duration,
      this.style,
      Curve curve = Curves.linear})
      : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedCountState();
}

class _AnimatedCountState extends AnimatedWidgetBaseState<AnimatedCount> {
  IntTween _count;

  @override
  Widget build(BuildContext context) {
    return new Text(_count.evaluate(animation).toStringWithFormat(), style: widget.style);
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _count = visitor(
        _count, widget.count, (dynamic value) => new IntTween(begin: value));
  }
}
