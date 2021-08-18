import 'dart:async';

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
import '../util/Utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  User user;

  @override
  void initState(){

    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

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

    listViews.add(
        CommonWidgets.singleTitleWithAnimation(LanguageMap.getValue("main.hisTitle"), widget.animationController)
    );
    listViews.add(
      RecentHisColumn(
          mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 1, 1.0,
                      curve: Curves.fastOutSlowIn))),
          mainScreenAnimationController: widget.animationController
      ),
    );

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
              top: AppBar().preferredSize.height + MediaQuery.of(context).size.height*0.12-40,
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
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Column(
                  children: <Widget>[Header(topBarOpacity: topBarOpacity, animationController: widget.animationController)],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
