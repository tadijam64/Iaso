import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatBubble extends StatefulWidget {
  bool right = true;
  String text = "";
  ChatBubble({this.text, this.right});
  @override
  State<StatefulWidget> createState() {
    return ChatBubbleState(this.text, this.right);
  }
}

class ChatBubbleState extends State<ChatBubble> {
  Color gradientStart = Color(0xFFD92525);
  bool right = true;
  String text = "";

  ChatBubbleState(this.text, this.right);

  double _width = 0, _widthSmall = 0;
  //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild(context));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        right
            ? AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: _widthSmall,
              )
            : Material(),
        AnimatedContainer(
            duration: Duration(milliseconds: 300),
            alignment: Alignment.centerLeft,
            width: _width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                color: right ? gradientStart : Colors.white),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(text,
                    style: TextStyle(
                        color: right ? Colors.white : Colors.grey[800],
                        fontSize: 16)))),
        !right
            ? Container(
                width: (MediaQuery.of(context).size.width * 0.12),
              )
            : Material()
      ],
    );
  }

  afterBuild(BuildContext context) {
    setState(() {
      _width = (MediaQuery.of(context).size.width * 0.68);
      _widthSmall = (MediaQuery.of(context).size.width * 0.12);
    });
  }
}
