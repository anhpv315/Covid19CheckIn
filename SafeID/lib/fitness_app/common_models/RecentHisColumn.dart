import 'package:SafeID/fitness_app/app_theme.dart';
import 'package:SafeID/fitness_app/models/historyMove.dart';
import 'package:flutter/material.dart';

import '../InheritedModel/InheritedObject.dart';

class RecentHisColumn extends StatefulWidget {
  const RecentHisColumn(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);
  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  _RecentHisColumnState createState() => _RecentHisColumnState();
}

class _RecentHisColumnState extends State<RecentHisColumn>
    with TickerProviderStateMixin {
  AnimationController animationController;

//  List<MealsListData> mealsListData = MealsListData.tabIconsList;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
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
    return StreamBuilder<List<HistoryMove>>(
        stream: InheritedObjects.of(context).hisList.myStream,
        builder: (BuildContext context, AsyncSnapshot<List<HistoryMove>> snapshot) {
          List<HistoryMove> list = InheritedObjects.of(context).hisList.currentRecentHisList;
          return Container(
//        height: (MediaQuery.of(context).size.height - 200),
              child: new ListView.builder(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 0, right: 16, left: 16),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Animation<double> animation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animationController,
                        curve: Interval((1 / 9) * index, 1.0,
                            curve: Curves.fastOutSlowIn)));
                    animationController.forward();
                    return HistoryMoveView(
                        HistoryListData: list[index],
                        animation: animation,
                        animationController: animationController,
                        index: index + 1);
                  }
              )
          );
        }
    );
  }
}

class HistoryMoveView extends StatelessWidget {
  const HistoryMoveView(
      {Key key,
      this.HistoryListData,
      this.animationController,
      this.animation,
      this.index})
      : super(key: key);

  final index;
  final HistoryMove HistoryListData;
  final AnimationController animationController;
  final Animation<dynamic> animation;


  @override
  Widget build(BuildContext context) {
    var topColor = [{'background': '#f1bd00', 'border': '#927201'}, {'background': '#c7c7c7', 'border': '#8e8e8e'}, {'background': '#c65b01', 'border': '#90420c'}, {'background': '#5e5e5e', 'border': '#4b4b4b'}, {'background': '#8CCC54', 'border': '#557831'}];
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
//                   Utils.updateCurrentDish(context, mealsListData.id);
//                   animationController.reverse().then<dynamic>((data) {
// //                      InheritedObjects.of(context).bodyWidget.setCurrentTab(4);
//                       Utils.updateTabIndex(context, 5);
//                     });
                },
                child:  SizedBox(
                    width: 200,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 8, right: 8, bottom: 0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
//                              boxShadow: <BoxShadow>[
//                                BoxShadow(
//                                    color: HexColor(mealsListData.endColor)
//                                        .withOpacity(0.6),
//                                    offset: const Offset(1.1, 4.0),
//                                    blurRadius: 8.0),
//                              ],
//                              gradient: LinearGradient(
//                                colors: <HexColor>[
//                                  HexColor(mealsListData.startColor),
//                                  HexColor(mealsListData.endColor),
//                                ],
//                                begin: Alignment.topLeft,
//                                end: Alignment.bottomRight,
//                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppTheme.grey.withOpacity(0.2),
                                    offset: Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                              color: AppTheme.nearlyWhite,
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 10, right: 5, bottom: 5),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            HistoryListData.location,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              letterSpacing: 0.2,
                                              color: AppTheme.darkText,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            HistoryListData.time,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontName,
                                              fontSize: 14,
                                              letterSpacing: 0.2,
                                              color: AppTheme.darkText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
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
