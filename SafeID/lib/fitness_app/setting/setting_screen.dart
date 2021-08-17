import 'package:SafeID/fitness_app/common_models/CommonWidgets.dart';
import 'package:SafeID/fitness_app/common_models/header.dart';
import 'package:SafeID/fitness_app/common_models/setting_items_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  double topBarOpacity = 0.0;
  final ScrollController scrollController = ScrollController();
  List<Widget> listView = <Widget>[];

  @override
  void initState() {
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
    const int count = 9;
    Animation animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: Interval((1 / 9) * 0, 1.0, curve: Curves.fastOutSlowIn)));

    listView.add(CommonWidgets.singleTitleWithAnimation('Cài đặt', widget.animationController));
    listView.add(
      SettingItemsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController,
                curve: Interval((1 / count) * 1, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );
    listView.add(SizedBox(
      height: 20,
    ));
    listView.add(CommonWidgets.singleTitleWithAnimation('Thông tin', widget.animationController));

    listView.add(
        AnimatedBuilder(
            animation: widget.animationController,
            builder: (BuildContext context, Widget child) {
              return FadeTransition(
                  opacity: animation,
                  child: new Transform(
                      transform: new Matrix4.translationValues(
                          0.0, 30 * (1.0 - animation.value), 0.0),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 16, bottom: 18),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.lightCyan,
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
                          padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                          child: Column(
                            children: <Widget>[
                              Text('Phần mềm gợi ý món ăn và tìm kiếm công thức nấu ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn ăn...'),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 24, right: 24, top: 8, bottom: 8),
                                child: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: AppTheme.background,
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                ),
                              ),
                              Text('Copyright by Pham Viet Anh.'),
                            ],
                          ),
                        ),
                      )
                  )
              );
            })
    );

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
            itemCount: listView.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listView[index];
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
                    Header(topBarOpacity: topBarOpacity, animationController: widget.animationController)
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
