import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/InheritedObject.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/CommonWidgets.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/LanguageMap.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/header.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/dish.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/user.dart';
import 'package:best_flutter_ui_templates/fitness_app/ui_view/mediterranesn_diet_view.dart';
import 'package:best_flutter_ui_templates/fitness_app/ui_view/title_view.dart';
import 'package:best_flutter_ui_templates/fitness_app/app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/util/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>
    with TickerProviderStateMixin {
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

  void addListUpdate(BuildContext context) {
    const int count = 3;
    Animation animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / 9) * 0, 1.0, curve: Curves.fastOutSlowIn)));
    User user = InheritedObjects.of(context).user.currentUser;
    // user = new User(id: 'abcxyz', name: "PHẠM VIỆT ANH", address: "303 ShynDongBil", phone: "01086820000", org_cd: "001", org_nm: "Hagidong");

    nameController.text = user.name;
    phoneController.text = user.phone;
    addrController.text = user.address;
    orgController.text = user.org_nm;


    listViews = [];

    listViews.add(
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
                          padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(LanguageMap.getValue("user.name")+ ":"),
                              TextField(controller: nameController),
                              SizedBox(height: 20,),
                              Text(LanguageMap.getValue("user.phone")+ ":"),
                              TextField(controller: phoneController),
                              SizedBox(height: 20,),
                              Text(LanguageMap.getValue("user.add")+ ":"),
                              TextField(controller: addrController),
                              SizedBox(height: 20,),
                              Text(LanguageMap.getValue("user.org")+ ":"),
                              TextField(controller: orgController),
                            ],
                          ),
                        ),
                      )
                  )
              );
            })
    );
    listViews.add(
        Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child:
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        status = "r";
                      });
                    },
                    color: AppTheme.white,
                    child: Icon(Icons.close, color: AppTheme.darkCyan),
                  ),
//              IconButton(icon: Icon(Icons.refresh, color: AppTheme.pink, size: 18), color: AppTheme.pink, onPressed: null)
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child:
                  RaisedButton(
                    onPressed: () {

                      setState(() {
                        status = "r";
                      });
                    },
                    color: AppTheme.darkCyan,
                    child: Icon(Icons.check, color: AppTheme.white),
                  ),
//              IconButton(icon: Icon(Icons.refresh, color: AppTheme.pink, size: 18), color: AppTheme.pink, onPressed: null)
                )
              ],
            )
        )
    );
  }
  void updateUserInfo(){


  }
  void addListView(BuildContext context) {
    const int count = 3;
    Animation animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval((1 / 9) * 0, 1.0, curve: Curves.fastOutSlowIn)));
    User user = InheritedObjects.of(context).user.currentUser;


    listViews = [];
    listViews.add(
        CommonWidgets.singleTitleWithAnimation(LanguageMap.getValue("main.info"), widget.animationController)
    );
    listViews.add(
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
                            left: 24, right: 24, top: 0, bottom: 18),
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
                          padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(LanguageMap.getValue("user.name")+ ":", style: TextStyle(fontWeight: FontWeight.w600),),
                              Text(user.name),
                              SizedBox(height: 20,),
                              Text(LanguageMap.getValue("user.phone")+ ":", style: TextStyle(fontWeight: FontWeight.w600),),
                              Text(user.phone),
                              SizedBox(height: 20,),
                              Text(LanguageMap.getValue("user.add")+ ":", style: TextStyle(fontWeight: FontWeight.w600),),
                              Text(user.address),
                              SizedBox(height: 20,),
                              Text(LanguageMap.getValue("user.org")+ ":", style: TextStyle(fontWeight: FontWeight.w600),),
                              
                              Text(user.org_nm),
                            ],
                          ),
                        ),
                      )
                  )
              );
            })
    );
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

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }



  @override
  Widget build(BuildContext context) {
    User u = InheritedObjects.of(context).user.currentUser;
    if(u.id == null || u.id == ""){
      status = "u";
    }
    status == "r"? addListView(context): addListUpdate(context);
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
