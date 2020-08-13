import 'package:flutter/material.dart';

class DefaultContainer extends StatelessWidget {
  DefaultContainer({Key key, this.child, this.color = Colors.white, this.height}) : super(key: key);

  final Widget child;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
      height: height,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 0.3),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          boxShadow: [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(8, 8),
          spreadRadius: 0,
          blurRadius: 10,
        )
      ]),
      child: Container(child: child),
    );
  }
}
