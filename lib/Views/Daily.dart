import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Common/AppBarGradient.dart';
import 'package:iaso/Common/Menu.dart';
import 'package:iaso/Models/DailyReports/GetDailyReportInteractor.dart';
import 'package:iaso/Models/DailyReports/ReportQuery.dart';
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

  //Gradient
  Color gradientStart = Color(0xFFD92525), gradientEnd = Color(0xFF8C0808);

  //Color gradientStart = Colors.blue, gradientEnd = Color(0xFF135a91);

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
                          CupertinoIcons.news,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Daily report",
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
                                  color: Colors.white,
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
    /*return WebView(
      initialUrl:
          'https://webchat.botframework.com/embed/dailyreporter?s=crAQ6gvsVJo.j7Jg74ZdJcEirRJpAxAgg6hQBLupuqUTMH4ceyOHOu8',
      javascriptMode: JavascriptMode.unrestricted,
    );*/
  }
}
