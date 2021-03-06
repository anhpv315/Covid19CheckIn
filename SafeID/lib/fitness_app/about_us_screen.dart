import 'package:safeID/fitness_app/common_models/CommonWidgets.dart';
import 'package:safeID/fitness_app/common_models/LanguageMap.dart';
import 'package:safeID/fitness_app/common_models/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'app_theme.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen>
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
        LanguageMap.getValue("main.about_us"), widget.animationController));
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: Text(
                              '???ng d???ng SafeID version 1.0.',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Ph??t tri???n b???i AtwoM Vi???t Nam.',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 16),
                            ),
                          )
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
                        left: 24, right: 24, top: 16, bottom: 18),
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
                        children: <Widget>[
                          Text("Tr?????c di???n bi???n ph???c t???p c???a d???ch Covid-19, nhi???u t???nh, th??nh ph??? ???? tri???n khai thi???t l???p c??c V??NG XANH an to??n ????? b???o v??? nh???ng khu v???c, c???m d??n c?? ch??a c?? ng?????i nhi???m Covid-19 ho???c ???? x??t nghi???m s??ng l???c di???n r???ng. ",
                            style: TextStyle(fontSize: 14, color: AppTheme.darkCyan),
                          ),
                          Text("Tr??n t??nh h??nh ????, SafeID - m???t gi???i ph??p do C??ng ty AtwoM Vi???t Nam cung c???p mi???n ph?? t???i c??c T??? t??? qu???n Covid-19 nh???m ki???m so??t c?? d??n ra, v??o V??ng Xanh b???ng m?? ?????nh danh c?? nh??n. ????? ra, v??o c??c ch???t ki???m so??t n??y, C?? d??n ch??? c???n th??ng b??o m?? c?? nh??n c???a m??nh ???????c hi???n th??? tr??n ??i???n tho???i di ?????ng m?? ho??n to??n kh??ng c???n k???t n???i m???ng hay bluetooth.",
                            style: TextStyle(fontSize: 14, color: AppTheme.darkCyan),
                          ),
                          SizedBox(height: 10,),
                          Text("????y s??? l?? m???t gi???i ph??p h???u ??ch, thu???n ti???n v?? tuy???t ?????i an to??n cho ng?????i s??? d???ng. H??y c??ng chung tay ?????y l??i ?????i d???ch Covid 19!",
                            style: TextStyle(fontSize: 14, color: AppTheme.darkCyan),
                          ),


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
