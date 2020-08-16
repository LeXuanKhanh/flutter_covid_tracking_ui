import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VaccineStatus extends StatefulWidget {
  @override
  _VaccineStatusState createState() => _VaccineStatusState();
}

class _VaccineStatusState extends State<VaccineStatus> {
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

  _launchURL() async {
    const url = 'https://www.bbc.com/news/world-europe-53735718';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("VaccineStatus"),
      onVisibilityChanged: onVisibilityChanged,
      child: AnimatedContainer(
        height: 300,
        margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Vaccine Status',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Expanded(
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: duration),
                    opacity: isHidden ? 0 : 1,
                    child: Image.asset(
                      'assets/check_mark.png',
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    child: Text('Learn More'),
                    onPressed: () => _launchURL(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
