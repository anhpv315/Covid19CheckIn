import 'dart:async';
import 'dart:io';

import 'package:safeID/fitness_app/app_theme.dart';
import 'package:safeID/fitness_app/common_models/header.dart';
import 'package:safeID/fitness_app/util/Encryption.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String id = '';
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
    expriredCode = true;



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
    initData();
    super.initState();
  }

  void getMessage() {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String strTime = dateFormat.format(DateTime.now());
    msg = pre + "&" + id + '&' + strTime;
    msg = Encryption.encrypt(msg);
//    print(msg);
//     print(Encryption.decrypt(msg));
//    print(msg.length);
  }

 Future<String> _getId() async {
   var deviceInfo = DeviceInfoPlugin();
   if (Platform.isIOS) {
     // import 'dart:io'
     var iosDeviceInfo = await deviceInfo.iosInfo;
     return iosDeviceInfo.identifierForVendor; // unique ID on iOS
   } else {
     var androidDeviceInfo = await deviceInfo.androidInfo;
     return androidDeviceInfo.androidId; // unique ID on Android
   }
 }

  Widget resetCounter() {
    counter = counterLength;
    this.setState(() {});
    expriredCode = false;
    int temp = counter;
    timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) async {
      temp--;
      if (temp < 0) {
        if(mounted){
          this.setState(() {
            expriredCode = true;
            timer.cancel();
          });
        }
      } else if (this.mounted) {
        if(mounted){
          this.setState(() {
            counter = temp;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  Future<bool> getData() async {

    return true;
  }

  void initData() async{
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
   id = await _getId();
//    id = "awaiting";
    print(id);
    getMessage();
    resetCounter();
  }
  @override
  Widget build(BuildContext context) {
//    getData();
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
                              LanguageMap.getValue("code.desc").isEmpty? "":LanguageMap.getValue("code.desc"),
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
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
                                    child:
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          LanguageMap.getValue("code.id").isNotEmpty?LanguageMap.getValue("code.id"): "" +
                                              ": ",
                                          style: TextStyle(
                                              fontSize: 13, fontFamily: "Sans"),
                                          textAlign: TextAlign.center,
                                        ),
                                        Flexible(
                                          child: Container(
                                            // color: Colors.red,
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              strutStyle: StrutStyle(fontSize: 13.0),
                                              text: TextSpan(
                                                  style: TextStyle(color: AppTheme.darkerText, fontFamily: "Sans", fontWeight: FontWeight.w800),
                                                  text: id),
                                            ),
                                          )
                                        ),
                                        // Text(
                                        //   id,
                                        //   style: TextStyle(
                                        //       fontWeight: FontWeight.w600,
                                        //       fontFamily: "Sans",
                                        //       fontSize: 13),
                                        // ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.copy,
                                              color: AppTheme.darkCyan,
                                            ),
                                            onPressed: () {
                                              Clipboard.setData(
                                                  ClipboardData(text: id));
                                              Fluttertoast.showToast(
                                                  msg: LanguageMap.getValue("code.copyMsg").isNotEmpty?LanguageMap.getValue("code.copyMsg"):"",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      AppTheme.lightCyan,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(10),
                                    child: msg == null || msg == ""? Container(width: 200, height: 200,): QrImage(
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
                                    Text(LanguageMap.getValue("code.expired").isNotEmpty?LanguageMap.getValue("code.expired"):"" +
                                        ":"),
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
                                  LanguageMap.getValue("code.refresh").isNotEmpty?LanguageMap.getValue("code.refresh"):"",
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
            )));
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
