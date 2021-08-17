import 'package:best_flutter_ui_templates/fitness_app/app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/LanguageMap.dart';
import 'package:best_flutter_ui_templates/fitness_app/theme/color/light_color.dart';
import 'package:best_flutter_ui_templates/fitness_app/util/HexColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:best_flutter_ui_templates/fitness_app/util/Utils.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../InheritedModel/InheritedObject.dart';
import '../util/Utils.dart';

class Header extends StatefulWidget {
  const Header({Key key, this.topBarOpacity, this.animationController})
      : super(key: key);
  final double topBarOpacity;
  final AnimationController animationController;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> with TickerProviderStateMixin {
  Widget leftButton;
  Widget centerHeader;
  Widget rightButton;
  Widget bottomHeader;
  final TextEditingController _typeAheadController = TextEditingController();
  String selected;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _header(context, widget.topBarOpacity);
  }

  Widget _header(BuildContext context, topBarOpacity) {
    var width = MediaQuery.of(context).size.width;
    var height =  MediaQuery.of(context).size.height*0.1 + 20;
    initButton(context);

    return Visibility(

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
                    left: 60,
                    child: Image.asset('assets/images/shield2.png', width: 100, )
                ),
                Positioned(
                    top: 30,
                    right: 40,
                    child: Image.asset('assets/images/virus2.png', width: 150,)
                ),
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
                        width: width > 0? width: 1,
                        height: height > 0? height: 1,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: MediaQuery.of(context).size.height*0.1-40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                 leftButton,
                                centerHeader,
                                rightButton
                              ],
                            ),
                          ],
                        )))
              ],
            )
        ),
    );
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget bubbleItem(String name, String link) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        color: AppTheme.nearlyWhite,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 6, left: 8, right: 8, bottom: 6),
        child: Text(
          name,
          style: TextStyle(
              color: LightColor.darkpurple, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void backFunction(
      BuildContext context, AnimationController animationController) {
    int currentTab = InheritedObjects.of(context).bodyWidget.currentBody;
    if (currentTab == 4) {
      animationController.reverse().then<dynamic>((data) {
        Utils.updateTabIndex(context, 0);

//        BodyWidgetInherited.of(context).bodyWidget.setCurrentTab(0);
      });
    }
  }

  Widget headTitle(String content){
    return Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppTheme.nearlyWhite,
          fontWeight: FontWeight.w600,
          fontSize: 24
      )
    );
  }

  void initButton(BuildContext context) {
    int currentTab = InheritedObjects.of(context).bodyWidget.currentBody;
    rightButton = new SizedBox(
        height: 30.0,
        width: 30.0,
        child:  Padding(
            padding:
            const EdgeInsets.only(top: 2, left:0, right: 8, bottom: 0),
            child:
            // IconButton(
            // padding: new EdgeInsets.all(0.0),
            // icon: new Icon(Icons.search, color: AppTheme.darkCyan, size: 30),
            // onPressed: () {
            //   setState(() {
            //     selected = _typeAheadController.text;
            //     if(selected == null || selected.trim() == ''){
            //       return false;
            //     }
            //     // Utils.updateSearchResult(context, selected);
            //     InheritedObjects.of(context).keyword.updateKeyword(selected);
            //     widget.animationController.reverse().then<dynamic>((data) {
            //       Utils.updateTabIndex(context, 9);
            //     });
            //   });
            // })
          Container()
        )
    );
    centerHeader = IntrinsicHeight(
        child: Container(
        width: MediaQuery.of(context).copyWith().size.width - 120,
        margin: const EdgeInsets.only(left: 0, right: 0),
        decoration: BoxDecoration(
          // color: Colors.black12,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child:
        Padding(
              padding:
              const EdgeInsets.only(top: 0, left: 8, right: 8, bottom: 0),
              // child: currentTab == 4? headTitle(LanguageMap.getValue("code.qrTitle")):  headTitle("APROTECT"),
              child: Text(""),

        ),
        )
    );

    leftButton =  !{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}.contains(currentTab)?
    new SizedBox(
        height: 30.0,
        width: 30.0,
        child: IconButton(
            padding: const EdgeInsets.only(top: 2, left:0, right: 8, bottom: 0),
            icon: new Icon(Icons.menu, color: AppTheme.nearlyWhite, size: 30),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }))
        : new SizedBox(
           height: 30.0,
           width: 30.0,
           child: IconButton(
               padding: const EdgeInsets.only(top: 12, left:0, right: 8, bottom: 0),
               icon: new Icon(Icons.chevron_left, color: AppTheme.nearlyWhite, size: 30),
               onPressed: () {
                 setState(() {
                   widget.animationController.reverse().then<dynamic>((data) {
 //                    InheritedObjects.of(context).bodyWidget.setCurrentTab(0);
                     Utils.backToLastTab(context);
                   });
                 });
               }));

  }
}
