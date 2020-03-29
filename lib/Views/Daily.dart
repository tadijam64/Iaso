import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaso/Common/AppBarGradient.dart';
import 'package:iaso/Common/Menu.dart';
import 'package:iaso/Models/DailyReports/GetDailyReportInteractor.dart';
import 'package:iaso/Models/DailyReports/ReportQuery.dart';
import 'package:iaso/Widget/Chat.dart';
import 'package:iaso/Widget/Typing.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Daily extends StatefulWidget {
  DailyState createState() => new DailyState();
}

class DailyState extends State<Daily> {
  @override
  Widget build(BuildContext context) {
    /* GetDailyReportInteractor()
        .getReport(new ReportQuery(question: "What is the report for today?"))
        .then((response) {
      print(response.toJson().toString());
      // you can have multiple answers in a list
      // prompts to display for a user are found in Context prompts Display text
      // these display text are also what you will show to the user, and send as a new query if user clicks it
      GetDailyReportInteractor()
          .getReport(new ReportQuery(
              question: response.answers[0].context.prompts[0].displayText))
          .then((response) {
        print(response.toJson().toString());
      });
    });*/
    return pageScafold();
  }

  TextEditingController controller = new TextEditingController();
  ScrollController scrollController = new ScrollController();

  //Gradient
  Color gradientStart = Color(0xFFD92525), gradientEnd = Color(0xFF8C0808);

  //Color gradientStart = Colors.blue, gradientEnd = Color(0xFF135a91);

  List<Widget> messageBox = new List();

  Widget pageScafold() {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: Menu().tabBar(),
          onTap: (index) {
            Menu().transfer(context, index);
          },
          currentIndex: 1,
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    border: GradientCheatingBorder.fromBorderSide(
                      BorderSide.none,
                      gradient:
                          LinearGradient(colors: [gradientStart, gradientEnd]),
                    ),
                    middle: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Iaso",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  child: Scaffold(
                    body: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [gradientStart, gradientEnd]),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: _content(),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(70.0))),
                            )),
                      ),
                    ),
                  ));
            },
          );
        });
  }

  _content() {
    return Column(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: messageBox,
            ),
          ),
        )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                height: 40,
                child: CupertinoTextField(
                  keyboardType: TextInputType.multiline,
                  controller: controller,
                  maxLines: 999,
                ),
              )),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                  onTap: () => _sendMessage(),
                  child: Icon(
                    Icons.send,
                    size: 35,
                    color: gradientStart,
                  ))
            ],
          ),
        ),
      ],
    );

    /*return WebView(
                      initialUrl:
                          'https://webchat.botframework.com/embed/dailyreporter?s=crAQ6gvsVJo.j7Jg74ZdJcEirRJpAxAgg6hQBLupuqUTMH4ceyOHOu8',
                      javascriptMode: JavascriptMode.unrestricted,
                    );*/
  }

  _sendMessage() {
    String message = controller.text;
    controller.text = "";
    FocusScope.of(context).unfocus();

    setState(() {
      messageBox.add(
        ChatBubble(
          right: true,
          text: message,
        ),
      );

      messageBox.add(
        SizedBox(
          height: 10,
        ),
      );
    });

    Widget typing = Typing();
    setState(() {
      messageBox.add(
        typing,
      );
    });

    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500), curve: Curves.ease);

    GetDailyReportInteractor()
        .getReport(new ReportQuery(question: message))
        .then((response) {
      setState(() {
        messageBox.removeLast();

        response.answers.forEach((f) {
          messageBox.add(
            ChatBubble(
              right: false,
              text: f.answer,
            ),
          );
          messageBox.add(
            SizedBox(
              height: 10,
            ),
          );
        });

        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      });
    });
  }
}
