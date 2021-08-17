import 'package:SafeID/fitness_app/common_models/CommonWidgets.dart';
import 'package:SafeID/fitness_app/common_models/LanguageMap.dart';
import 'package:SafeID/fitness_app/common_models/header.dart';
import 'package:SafeID/fitness_app/models/dish.dart';
import 'package:SafeID/fitness_app/ui_view/mediterranesn_diet_view.dart';
import 'package:SafeID/fitness_app/ui_view/title_view.dart';
import 'package:SafeID/fitness_app/app_theme.dart';
import 'package:SafeID/fitness_app/util/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopDishesScreen extends StatefulWidget {
  const TopDishesScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _TopDishesScreenState createState() => _TopDishesScreenState();
}

class _TopDishesScreenState extends State<TopDishesScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

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

  void addAllListData(BuildContext context) {
    const int count = 9;
    listViews = [];
    listViews.add(Container());
    // listViews.add(CommonWidgets.singleTitleWithAnimation(LanguageMap.getValue("main.top_favorite"), widget.animationController));
    // listViews.add(
    //   ListTopColumn(
    //     mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //         CurvedAnimation(
    //             parent: widget.animationController,
    //             curve: Interval((1 / count) * 1, 1.0,
    //                 curve: Curves.fastOutSlowIn))),
    //     mainScreenAnimationController: widget.animationController
    //   ),
    // );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }



  @override
  Widget build(BuildContext context) {
    addAllListData(context);

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

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
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
                  children: <Widget>[
                    Header(
                        topBarOpacity: topBarOpacity,
                        animationController: widget.animationController)
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
