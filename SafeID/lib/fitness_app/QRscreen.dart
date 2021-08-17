import 'dart:async';

import 'package:SafeID/fitness_app/common_models/CommonWidgets.dart';
import 'package:SafeID/fitness_app/common_models/header.dart';
import 'package:SafeID/fitness_app/models/dish.dart';
import 'package:SafeID/fitness_app/ui_view/mediterranesn_diet_view.dart';
import 'package:SafeID/fitness_app/util/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'app_theme.dart';
import 'package:encrypt/encrypt.dart' as encryption;
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
  String pre = '0';
//  String textMessage = 'This app is created by AtwoM Vietnam for non-profit purposes';
  String textMessage =
      'Đoạn này để cho code phức tạp hơn thôi không cần quan tâm';
  String id = 'daylastringID';
  final int counterLength = 15;
  String msg;
  int counter;
  Timer timer;
  bool expriredCode = true;
  final enCryptKey = encryption.Key.fromUtf8('atwomvietnam2021');
  final iv = encryption.IV.fromUtf8('atwomvietnam2021');

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

  void getMessage() async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String strTime = dateFormat.format(DateTime.now());
      final encrypter = encryption.Encrypter(encryption.AES(enCryptKey));

    msg = pre + '|' + id + '|' + strTime + '|' + textMessage;
    print(msg);

    msg = encrypter.encrypt(msg, iv: iv).base64;
    print(msg);
    setState(() {


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
                        SizedBox(
                          height: 10,
                        )
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
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        LanguageMap.getValue("code.copyID"),
                                        style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
//                            IconButton(
//                                padding: EdgeInsets.all(1),
//                                icon: Icon(
//                              Icons.info_outline,
//                              size: 13,
//                            ), onPressed: (){
//                              Fluttertoast.showToast(
//                                  msg: LanguageMap.getValue("code.copied"),
//                                  toastLength: Toast.LENGTH_SHORT,
//                                  gravity: ToastGravity.CENTER,
//                                  timeInSecForIosWeb: 1,
//                                  backgroundColor: AppTheme.lightCyan,
//                                  textColor: Colors.white,
//                                  fontSize: 14.0
//                              );
//                            })
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        color: AppTheme.nearlyWhite,
                                        child: Text(
                                          id,
                                          style: TextStyle(fontSize: 14),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ButtonTheme(
                                        height: 30.0,
                                        minWidth: 30,
                                        child: RaisedButton(
                                          onPressed: () {
                                            Clipboard.setData(
                                                ClipboardData(text: id));
                                            Fluttertoast.showToast(
                                                msg: LanguageMap.getValue("code.copied"),
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: AppTheme.lightCyan,
                                                textColor: Colors.white,
                                                fontSize: 14.0
                                            );
                                          },
                                          color: AppTheme.white,
                                          child: Icon(Icons.copy,
                                            color: AppTheme.darkCyan, size: 14,),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
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
                            SizedBox(
                              height: 10,
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
                      )),


                ],
              ),
            ),
            getAppBarUI(),
//            SizedBox(
//              height: MediaQuery.of(context).padding.bottom,
//            )
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height * 0.1 + 20;
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Visibility(
              child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    color: AppTheme.darkCyan,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.2),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                          top: 20,
                          left: 50,
                          child: Image.asset(
                            'assets/images/shield2.png',
                            width: 100,
                          )),
                      Positioned(
                          top: 35,
                          right: 20,
                          child: Image.asset(
                            'assets/images/virus2.png',
                            width: 150,
                          )),
                      // Positioned(
                      //     top: -100,
                      //     left: -45,
                      //     child:
                      //         _circularContainer(width * .5,  AppTheme.darkText)),
                      // Positioned(
                      //     top: -180,
                      //     right: -30,
                      //     child: _circularContainer(width * .7, Colors.transparent,
                      //         borderColor: Colors.white38)),
                      Positioned(
                          top: 10,
                          left: 0,
                          child: Container(
                              width: width > 0 ? width : 1,
                              height: height > 0 ? height : 1,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                                  0.1 -
                                              40),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new SizedBox(
                                          height: 30.0,
                                          width: 30.0,
                                          child: IconButton(
                                              padding: const EdgeInsets.only(
                                                  top: 2,
                                                  left: 0,
                                                  right: 8,
                                                  bottom: 0),
                                              icon: new Icon(Icons.chevron_left,
                                                  color: AppTheme.nearlyWhite,
                                                  size: 30),
                                              onPressed: () {
                                                setState(() {
                                                  widget.animationController
                                                      .reverse()
                                                      .then<dynamic>((data) {
                                                    //                    InheritedObjects.of(context).bodyWidget.setCurrentTab(0);
                                                    Utils.backToLastTab(
                                                        context);
                                                  });
                                                });
                                              }))
                                    ],
                                  ),
                                ],
                              )))
                    ],
                  )),
            )
          ],
        ),
      ],
    );
  }
}
