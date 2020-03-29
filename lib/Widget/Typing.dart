import 'package:flutter/material.dart';

class Typing extends StatefulWidget {
  TypingState createState() => new TypingState();
}

class TypingState extends State<Typing> {
  String _dots = "";
  double _width = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild(context));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(),
      width: _width,
      child: Row(
        children: <Widget>[
          Text(
            "Iaso is typing",
            style: TextStyle(color: Colors.grey[700], fontSize: 18),
          ),
          Text(
            _dots,
            style: TextStyle(color: Colors.grey[700], fontSize: 18),
          )
        ],
      ),
    );
  }

  afterBuild(BuildContext context) {
    setState(() {
      _width = double.infinity;
    });

    _startDot();
  }

  void _startDot() {
    setState(() {
      switch (_dots.length) {
        case 0:
          _dots = ".";
          break;
        case 1:
          _dots = "..";
          break;
        case 2:
          _dots = "...";
          break;
        case 3:
          _dots = "";
          break;
      }
    });

    new Future.delayed(const Duration(milliseconds: 750), _startDot);
  }
}
