import 'dart:async';

import 'package:best_flutter_ui_templates/fitness_app/common_models/CommonWidgets.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/header.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/dish.dart';
import 'package:best_flutter_ui_templates/fitness_app/ui_view/mediterranesn_diet_view.dart';
import 'package:best_flutter_ui_templates/fitness_app/util/Encryption.dart';
import 'package:best_flutter_ui_templates/fitness_app/util/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'app_theme.dart';
import 'common_models/LanguageMap.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  double topBarOpacity = 0.0;
  final ScrollController scrollController = ScrollController();
  List<Widget> listView = <Widget>[];
  String textMessage =
      'This app is created by AtwoM Vietnam for non-profit purposes';
  String pre = "0";
  String id = '53454234';
  final int counterLength = 15;
  String msg;
  int counter;
  Timer timer;
  bool expriredCode = true;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    getMessage();
    resetCounter();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void getMessage() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String strTime = dateFormat.format(DateTime.now());
    setState(() {
      msg = pre+ "&"+ id + '&' + strTime;
      msg = Encryption.encrypt(msg);
      print(msg);
      print(Encryption.decrypt(msg));
      print(msg.length);
    });
  }

  Widget resetCounter() {
    counter = counterLength;
    this.setState(() {});
    expriredCode = false;
    int temp = counter;
    timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) async {
      temp--;
      if (temp < 0) {
        this.setState(() {
          expriredCode = true;
          timer.cancel();
        });
      } else if (this.mounted) {
        this.setState(() {
          counter = temp;
        });
      } else {
        timer.cancel();
      }
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            // getMainListViewUI(),
            Padding(
              padding: EdgeInsets.only(
                top: AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top +
                    40,
                bottom: 62 + MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Column(
                      children: [
                        Text(
                          LanguageMap.getValue("code.desc"),
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppTheme.cyan),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              color: AppTheme.nearlyWhite,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      LanguageMap.getValue("code.id") + ": ",
                                      style: TextStyle(fontSize: 13),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: 10,
                                      height: 10,
                                    ),
                                    Text(
                                      id,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.copy, color: AppTheme.darkCyan,),
                                        onPressed: (){
                                          Clipboard.setData(ClipboardData(text: id));
                                          Fluttertoast.showToast(
                                              msg: LanguageMap.getValue("code.copyMsg") ,
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: AppTheme.lightCyan,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );

                                    })
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: QrImage(
                                  data: msg,
                                  foregroundColor: expriredCode
                                      ? Color(0xFFf1f1f1)
                                      : Color(0xFF000000),
                                  version: QrVersions.auto,
                                  size: 200.0,
                                )),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.access_time, size: 16),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    LanguageMap.getValue("code.expired") + ":"),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(counter.toString() + "s",
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                            Divider(
                              color: AppTheme.cyan,
                            ),
                            Text(
                              LanguageMap.getValue("code.refresh"),
                              style: TextStyle(fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Container(
                                  width: double.infinity,
                                  child: RaisedButton(
                                    onPressed: () {
                                      timer.cancel();
                                      getMessage();
                                      resetCounter();
                                    },
                                    color: AppTheme.darkCyan,
                                    child: Icon(Icons.refresh,
                                        color: AppTheme.white),
                                  ),
                                ))
                          ],
                        ),
                      ))
                ],
              ),
            ),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }


  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        Header(
            topBarOpacity: topBarOpacity,
            animationController: widget.animationController)
      ],
    );
  }
}
