import 'dart:async';
import 'dart:convert';

import 'package:best_flutter_ui_templates/fitness_app/common_models/CommonWidgets.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/LanguageMap.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/RecentHisColumn.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/header.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/user.dart';
import 'package:best_flutter_ui_templates/fitness_app/app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/util/LocalStorage.dart';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/fitness_app/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/Utils.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  User user;
  bool waiting = false;
  var tin = [];

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    leakNumbers();
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

  void leakNumbers() async {
    if (waiting) {
      return;
    }
//    print(1);
    if (tin.isEmpty) {
      final response = await http
          .get(Uri.parse('https://ncov.moh.gov.vn/vi/web/guest/tin-tuc'));
      String source = Utf8Decoder().convert(response.bodyBytes);
      if (response.statusCode == 200) {
        // print(source);
        tin = [];
        var regexp0 = new RegExp(
            r'a href="([\d|\w|\.|\:|\-|\/]*)"( title="[a-zA-Z\u00C0-\u017F\u0100-\u017F\u0180-\u024F\u1E00-\u1EFF\w|\s|\:]*")*><h2 class="mt-3">([a-zA-Z\u00C0-\u017F\u0100-\u017F\u0180-\u024F\u1E00-\u1EFF|\s|\d|\/|\:|\,|\-|\.|\[|\]]*)<');
        RegExpMatch temp2 = regexp0.firstMatch(source);
        var news = {};
        news['url'] = temp2.group(1);
        news['title'] = temp2.group(3);
        tin.add(news);

        var regexp = new RegExp(
            r' class="text-tletin" href="([\d|\w|\.|\:|\-|\/]*)"( title="[a-zA-Z\u00C0-\u017F\u0100-\u017F\u0180-\u024F\u1E00-\u1EFF\w|\s|\:]*")*>([a-zA-Z\u00C0-\u017F\u0100-\u017F\u0180-\u024F\u1E00-\u1EFF|\s|\d|\/|\:|\,|\-|\.|\[|\]]*)<');
        List<RegExpMatch> temp = regexp.allMatches(source).toList();
//        print(temp.length);
        temp.forEach((each) {
          var news = {};
          news['url'] = each.group(1);
          news['title'] = each.group(3);
          tin.add(news);
        });
        addAllListData();
        if (mounted) {
          setState(() {});
        }
        //        String url = regexp.allMatches(source).map((m) {
//              return m.group(1);
//            }).elementAt(0);
//        String title =             regexp.allMatches(source).map((m) => m.group(2)).elementAt(0);

        if (tin != []) {
          waiting = false;
        }
      } else {
        throw Exception('Failed to load dishes');
      }
    }

    waiting = true;
  }

  void addAllListData() {
    const int count = 4;

    Animation animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / 9) * 0, 1.0, curve: Curves.fastOutSlowIn)));
//     listViews.add(
//       TitleView(
//         titleTxt: LanguageMap.getValue("main.info"),
//         subTxt: LanguageMap.getValue("main.updateInfo"),
//         subTxtAction: (){
//           widget.animationController.reverse().then<dynamic>((data) {
//             Utils.updateTabIndex(context, 3);
//
// //            BodyWidgetInherited.of(context).bodyWidget.setCurrentTab(2);
//           });
//         },
//         animation: Tween<double>(begin: 0.0, end: 1.0).animate(
//             CurvedAnimation(
//                 parent: widget.animationController,
//                 curve:
//                     Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn)
//             )
//         ),
//         animationController: widget.animationController,
//       ),
//     );
    // listViews.add(
    //     CommonWidgets.singleTitleWithAnimation(LanguageMap.getValue("main.info"), widget.animationController)
    // );
    // listViews.add(AnimatedBuilder(
    //     animation: widget.animationController,
    //     builder: (BuildContext context, Widget child) {
    //       user = InheritedObjects.of(context).user.currentUser;
    //       return FadeTransition(
    //           opacity: topBarAnimation,
    //           child: new Transform(
    //               transform: new Matrix4.translationValues(
    //                   0.0, 30 * (1.0 - animation.value), 0.0),
    //               child: Padding(
    //                 padding: const EdgeInsets.only(
    //                     left: 24, right: 24, top: 16, bottom: 18),
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     color: AppTheme.lightCyan,
    //                     borderRadius: BorderRadius.only(
    //                         topLeft: Radius.circular(8.0),
    //                         bottomLeft: Radius.circular(24.0),
    //                         bottomRight: Radius.circular(8.0),
    //                         topRight: Radius.circular(24.0)),
    //                     boxShadow: <BoxShadow>[
    //                       BoxShadow(
    //                           color: AppTheme.grey.withOpacity(0.2),
    //                           offset: Offset(1.1, 1.1),
    //                           blurRadius: 10.0),
    //                     ],
    //                   ),
    //                   padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     crossAxisAlignment: CrossAxisAlignment.stretch,
    //                     children: <Widget>[
    //                       Text(user.name != null? user.name: "", style: TextStyle(fontWeight: FontWeight.w600),),
    //                       Text(user.address != null? user.address: ""),
    //                       Text(user.org_nm != null? user.org_nm: ""),
    //                     ],
    //                   ),
    //                 ),
    //               )));
    //     }));

    listViews.add(CommonWidgets.singleTitleWithAnimation(
        LanguageMap.getValue("news.news"), widget.animationController));
    if (tin.isNotEmpty) {
      tin.forEach((element) {
        listViews.add(AnimatedBuilder(
            animation: widget.animationController,
            builder: (BuildContext context, Widget child) {
              double width = MediaQuery.of(context).size.width;

              return FadeTransition(
                  opacity: animation,
                  child: new Transform(
                      transform: new Matrix4.translationValues(
                          0.0, 30 * (1.0 - animation.value), 0.0),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 0, bottom: 18),
                          child: GestureDetector(
                            onTap: () {
//                              print('tap');
                              openURL(element["url"]);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.nearlyWhite,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: AppTheme.grey.withOpacity(0.2),
                                        offset: Offset(1.1, 1.1),
                                        blurRadius: 10.0),
                                  ],
                                ),
                                padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width - 100,
                                      child: Text(
                                        element["title"],
                                        style:
                                            TextStyle(color: AppTheme.darkText),
                                      ),
                                    ),
                                    Icon(Icons.chevron_right),
                                  ],
                                )),
                          ))));
            }));
      });
    }
  }

  void openURL(String url) async {
//    print("run "+ url);
    if (await canLaunch(url))
    await launch(url);
    else
    // can't launch url, there is some error
    throw "Could not launch $url";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Restart app is required.'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please open app again to apply changes!'),
              ],
            ),
          ),
          actions: <Widget>[
//            TextButton(
//              child: Text('OK'),
//              onPressed: () {
////                context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
//              },
//            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                setState(() => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      )
                    });
              },
            ),
          ],
        );
      },
    );
  }

  Widget getMainListViewUI() {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).size.height * 0.12 -
            40,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: listViews.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        widget.animationController.forward();
        return listViews[index];
      },
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
