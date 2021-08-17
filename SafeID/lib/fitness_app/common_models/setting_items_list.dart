import 'package:SafeID/fitness_app/app_theme.dart';
import 'package:SafeID/fitness_app/models/dish.dart';
import 'package:SafeID/fitness_app/models/setting_list_data.dart';
import 'package:SafeID/main.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../InheritedModel/InheritedObject.dart';
import '../util/Utils.dart';

class SettingItemsListView extends StatefulWidget {
  const SettingItemsListView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  _SettingItemsListViewState createState() => _SettingItemsListViewState();
}

class _SettingItemsListViewState extends State<SettingItemsListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<SettingListData> mealsListData = SettingListData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//        height: (MediaQuery.of(context).size.height - 200),
        child: new ListView.builder(
            padding: const EdgeInsets.only(
                top: 0, bottom: 0, right: 16, left: 16),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: mealsListData.length,
            itemBuilder: (BuildContext context, int index) {
              final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / 9) * index, 1.0,
                          curve: Curves.fastOutSlowIn)));
              animationController.forward();

              return SettingView(
                  mealsListData: mealsListData[index],
                  animation: animation,
                  animationController: animationController,
                  index: index + 1);
            }));
  }
}

class SettingView extends StatelessWidget {
  const SettingView(
      {Key key,
      this.mealsListData,
      this.animationController,
      this.animation,
      this.index})
      : super(key: key);

  final index;
  final SettingListData mealsListData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: GestureDetector(
                onTap: (){
                    animationController.reverse().then<dynamic>((data) {
//                      InheritedObjects.of(context).bodyWidget.setCurrentTab(4);
                      Utils.updateTabIndex(context, 5);
                    });
                },
                child:  SizedBox(
                    width: 200,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 8, right: 8, bottom: 0),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.grey.withOpacity(0.2),
                                    offset: Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                              color: AppTheme.lightCyan,
                              // gradient: LinearGradient(
                              //   colors: <HexColor>[
                              //     HexColor(mealsListData.startColor),
                              //     HexColor(mealsListData.endColor),
                              //   ],
                              //   begin: Alignment.topLeft,
                              //   end: Alignment.bottomRight,
                              // ),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(54.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 36, right: 16, bottom: 8),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          mealsListData.titleTxt,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: 0.2,
                                            color: AppTheme.darkText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                )
            )
          ),
        );
      },
    );
  }
}
