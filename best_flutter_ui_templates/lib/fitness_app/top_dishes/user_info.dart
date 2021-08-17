import 'dart:convert';

import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/InheritedObject.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/CommonWidgets.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/LanguageMap.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/header.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/dish.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/user.dart';
import 'package:best_flutter_ui_templates/fitness_app/ui_view/mediterranesn_diet_view.dart';
import 'package:best_flutter_ui_templates/fitness_app/ui_view/title_view.dart';
import 'package:best_flutter_ui_templates/fitness_app/app_theme.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  User currentUser;
  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController addrController;
  TextEditingController orgController;
  String status = "r";

  String ca_nhiem = "";
  String dang_dieu_tri = "";
  String khoi = "";
  String tu_vong = "";
  String ca_nhiem_g = "";
  String dang_dieu_tri_g = "";
  String khoi_g = "";
  String tu_vong_g = "";
  String dk = "";
  String tiem_24h = "";
  String da_tiem = "";

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    nameController = new TextEditingController();
    phoneController = new TextEditingController();
    addrController = new TextEditingController();
    orgController = new TextEditingController();

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
    ///////// goi nhieu lan
    print(1);
    if(ca_nhiem == "") {
      final response = await http.get(Uri.parse('https://ncov.moh.gov.vn/'));
      String source = Utf8Decoder().convert(response.bodyBytes);

      if (response.statusCode == 200) {
        // print(source);
        var regexp = new RegExp(
            r'Số ca nhiễm <br> <span class="font24">([\d|\.]*)</span>');
        ca_nhiem =
            regexp.allMatches(source).map((m) => m.group(1)).elementAt(0);
        var regexp2 = new RegExp(
            r'Đang điều trị <br> <span class="font24">([\d|\.]*)</span>');
        dang_dieu_tri =
            regexp2.allMatches(source).map((m) => m.group(1)).elementAt(0);
        var regexp3 =
        new RegExp(r'Khỏi <br> <span class="font24">([\d|\.]*)</span>');
        khoi = regexp3.allMatches(source).map((m) => m.group(1)).elementAt(0);
        var regexp4 =
        new RegExp(r'Tử vong <br> <span class="font24">([\d|\.]*)</span>');
        tu_vong =
            regexp4.allMatches(source).map((m) => m.group(1)).elementAt(0);

        regexp = new RegExp(
            r'Tổng ca nhiễm <br> <span class="font24">([\d|\.]*)</span>');
        ca_nhiem_g =
            regexp.allMatches(source).map((m) => m.group(1)).elementAt(0);
        regexp2 =
        new RegExp(r'Đang nhiễm <br> <span class="font24">([\d|\.]*)</span>');
        dang_dieu_tri_g =
            regexp2.allMatches(source).map((m) => m.group(1)).elementAt(0);
        regexp3 =
        new RegExp(r'Khỏi <br> <span class="font24">([\d|\.]*)</span>');
        khoi_g = regexp3.allMatches(source).map((m) => m.group(1)).elementAt(1);
        regexp4 =
        new RegExp(r'Tử vong <br> <span class="font24">([\d|\.]*)</span>');
        tu_vong_g =
            regexp4.allMatches(source).map((m) => m.group(1)).elementAt(1);
      } else {
        throw Exception('Failed to load dishes');
      }
    }

    if(dk == "") {
      final response2 = await http.get(Uri.parse(
          'https://tiemchungcovid19.gov.vn/api/public/dashboard/vaccination-statistics/summary'));
      String source2 = Utf8Decoder().convert(response2.bodyBytes);
      if (response2.statusCode == 200) {
        // print(source);
        var result = json.decode(source2);
        dk = numberTemplate(result['totalVaccinationRegistration'].toString());
        if (mounted) {
          setState(() {

          });
        }
      } else {
        throw Exception('Failed to load dishes');
      }
    }

    if(tiem_24h == "") {
      final response3 = await http.get(Uri.parse(
          'https://tiemchungcovid19.gov.vn/api/public/dashboard/vaccination-statistics/get-detail-latest'));
      String source3 = Utf8Decoder().convert(response3.bodyBytes);
      if (response3.statusCode == 200) {
        // print(source);
        var result = json.decode(source3);
        tiem_24h = numberTemplate(result['totalPopulation'].toString());
        da_tiem = numberTemplate(result['objectInjection'].toString());
        if (mounted) {
          setState(() {

          });
        }
      } else {
        throw Exception('Failed to load dishes');
      }
    }
  }

  void updateUserInfo() {}
  void addListView(BuildContext context) {
    const int count = 3;
    Animation animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / 9) * 0, 1.0, curve: Curves.fastOutSlowIn)));
    User user = InheritedObjects.of(context).user.currentUser;

    listViews = [];
    listViews.add(CommonWidgets.singleTitleWithAnimation(
        LanguageMap.getValue("main.news"), widget.animationController));
    listViews.add(AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
              opacity: animation,
              child: new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30 * (1.0 - animation.value), 0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 0, bottom: 18),
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
                      padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            LanguageMap.getValue("news.national"),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                LanguageMap.getValue("news.cases") + ":",
                                style: TextStyle(color: Color(0xFF8B0000)),
                              ),
                              SizedBox(width: 10,),
                              Text(ca_nhiem,
                                style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF8B0000)),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                LanguageMap.getValue("news.treated") + ":",
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                              SizedBox(width: 10,),
                              Text(dang_dieu_tri,
                                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.deepOrange),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                LanguageMap.getValue("news.cured") + ":",
                                style: TextStyle( color: Colors.green),
                              ),
                              SizedBox(width: 10,),
                              Text(khoi,
                                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                LanguageMap.getValue("news.dead") + ":",
                                style: TextStyle(color: Color(0xFF808080)),
                              ),
                              SizedBox(width: 10,),
                              Text(tu_vong,
                                style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF808080)),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                LanguageMap.getValue("news.registed") + ":",
                                style: TextStyle(color:  AppTheme.darkCyan),
                              ),
                              SizedBox(width: 10,),
                              Text(dk,
                                style: TextStyle(fontWeight: FontWeight.w600, color:  AppTheme.darkCyan),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                LanguageMap.getValue("news.24h") + ":",
                                style: TextStyle( color:  AppTheme.darkCyan),
                              ),
                              SizedBox(width: 10,),
                              Text(tiem_24h,
                                style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.darkCyan),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                LanguageMap.getValue("news.all") + ":",
                                style: TextStyle(color: AppTheme.darkCyan),
                              ),
                              SizedBox(width: 10,),
                              Text(da_tiem,
                                style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.darkCyan),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  )));
        }));
    listViews.add(AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
              opacity: animation,
              child: new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30 * (1.0 - animation.value), 0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 0, bottom: 18),
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
                      padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            LanguageMap.getValue("news.international"),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Divider(),
                          Row(
                            children: [
                              Text(
                                LanguageMap.getValue("news.cases") + ":",
                                style: TextStyle( color: Color(0xFF8B0000)),
                              ),
                              SizedBox(width: 10,),
                              Text(ca_nhiem_g,
                                style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF8B0000)),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                LanguageMap.getValue("news.treated") + ":",
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                              SizedBox(width: 10,),
                              Text(dang_dieu_tri_g,
                                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.deepOrange),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                LanguageMap.getValue("news.cured") + ":",
                                style: TextStyle(color: Colors.green),
                              ),
                              SizedBox(width: 10,),
                              Text(khoi_g,
                                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                LanguageMap.getValue("news.dead") + ":",
                                style: TextStyle(color:  Color(0xFF808080)),
                              ),
                              SizedBox(width: 10,),
                              Text(tu_vong_g,
                                style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF808080)),
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                  )));
        }));
//     listViews.add(
//         Padding(
//             padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
//             child: Container(
//               child:
//               RaisedButton(
//                 onPressed: () {
//                   setState(() {
//                     status = "u";
//                   });
//                 },
//                 color: AppTheme.darkCyan,
//                 child: Icon(Icons.edit, color: AppTheme.white),
//               ),
// //              IconButton(icon: Icon(Icons.refresh, color: AppTheme.pink, size: 18), color: AppTheme.pink, onPressed: null)
//             )
//         )
//     );
  }

  String numberTemplate(String num){
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';
    return num.replaceAllMapped(reg, mathFunc).replaceAll(",", ".");
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    leakNumbers();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    getData();
    addListView(context);
    // addListUpdate(context);
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
    return StreamBuilder<User>(
      stream: InheritedObjects.of(context).user.myStream,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
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
