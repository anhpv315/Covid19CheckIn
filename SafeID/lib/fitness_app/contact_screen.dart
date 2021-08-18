import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/InheritedObject.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/CommonWidgets.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/LanguageMap.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/header.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/dish.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'app_theme.dart';
import 'util/HexColor.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with TickerProviderStateMixin {
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
    listView = [];
    const int count = 9;
    Animation animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / 9) * 0, 1.0, curve: Curves.fastOutSlowIn)));
    listView.add(CommonWidgets.singleTitleWithAnimation(
        LanguageMap.getValue("main.contact"), widget.animationController));
    
    listView.add(AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
              opacity: animation,
              child: new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30 * (1.0 - animation.value), 0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 16, bottom: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(40.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.grey.withOpacity(0.2),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Icon(Icons.call, color: AppTheme.darkText,),
                              Padding(padding: EdgeInsets.all(5)),
                              Text(LanguageMap.getValue("contact.phone_number"), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),)
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: TextStyle(fontSize: 14, color: HexColor('#43547a')),
                              children: <TextSpan>[
                                TextSpan(text: '(+84) 0866 688 668\n'),
//                                TextSpan(text: '(+84) 0966 699 669'),
                              ],
                            ),
                          ),
//                          Text('(+84) 0866 688 668', style: TextStyle(fontSize: 18),),
//                          Text('(+84) 0966 699 669',  style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),
                  )));
        }));
    listView.add(AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
              opacity: animation,
              child: new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30 * (1.0 - animation.value), 0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 16, bottom: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(40.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.grey.withOpacity(0.2),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Icon(Icons.email_outlined, color: AppTheme.darkText,),
                              Padding(padding: EdgeInsets.all(5)),
                              Text('Email', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),)
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: TextStyle(fontSize: 14, color: HexColor('#43547a')),
                              children: <TextSpan>[
                                TextSpan(text: 'hotline@atwom.com.vn\n'),
//                                TextSpan(text: 'homnayangi@gmail.com'),
                              ],
                            ),
                          ),
//                          Text('whatmenutoday.feedback@gmail.com', style: TextStyle(fontSize: 18),),
//                          Text('homnayangi@gmail.com', style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),
                  )));
        }));
    listView.add(AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
              opacity: animation,
              child: new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30 * (1.0 - animation.value), 0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 16, bottom: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(40.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(40.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.grey.withOpacity(0.2),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: TextStyle(fontSize: 14, color: HexColor('#43547a')),
                              children: <TextSpan>[
                                TextSpan(text: 'Xin chân thành cảm ơn mọi ý kiến đóng góp và xây dựng để chúng tôi ngày càng hoàn thiện hơn.'),
//                                TextSpan(text: 'WhatMenuToday', style: TextStyle(fontWeight: FontWeight.bold)),
//                                TextSpan(text: ' ngày càng hoàn thiện hơn.'),
                              ],
                            ),
                          ),
                          // Text('Xin chân thành cảm ơn mọi ý kiến đóng góp và xây dựng để WhatMenuToday ngày càng hoàn thiện hơn.'),
                        ],
                      ),
                    ),
                  )));
        }));

//    listView.add(
//      MediterranesnDietView(
//        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
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
      },
    );
  }

  Widget htmlContent(String htmlString) {
    return Html(
      data: "" + htmlString + "",
      //Optional parameters:
//    backgroundColor: Colors.white70,
      onLinkTap: (url) {
        // open url in a webview
      },
      style: {
//      "div": Style(
//        block: Block(
//          margin: EdgeInsets.all(16),
//          border: Border.all(width: 6),
//          backgroundColor: Colors.grey,
//        ),
//        textStyle: TextStyle(
//          color: Colors.red,
//        ),
//      ),
      },
      onImageTap: (src) {
        // Display the image in large form.
      },
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
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).size.height * 0.12 -
                  40,
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
        Header(
            topBarOpacity: topBarOpacity,
            animationController: widget.animationController)
      ],
    );
  }
}
