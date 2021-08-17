import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/InheritedObject.dart';
import 'package:best_flutter_ui_templates/fitness_app/QRscreen.dart';
import 'package:best_flutter_ui_templates/fitness_app/about_us_screen.dart';
import 'package:best_flutter_ui_templates/fitness_app/contact_screen.dart';
import 'package:best_flutter_ui_templates/fitness_app/top_dishes/top_dishes.dart';
import 'package:best_flutter_ui_templates/fitness_app/util/Utils.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/tabIcon_data.dart';
import 'package:best_flutter_ui_templates/fitness_app/suggestion/suggestion_screen.dart';
import 'package:best_flutter_ui_templates/fitness_app/top_dishes/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'app_theme.dart';
import 'models/user.dart';
import 'my_diary/home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> topBarAnimation;
  double topBarOpacity = 0.0;
  // User currentUser = new User();
  Widget tabBody = Container(
    color: AppTheme.background,
  );


  @override
  Future<void> initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));


    // loadUser();

    super.initState();
  }

  void loadUser() async{

    await setDataToLocal();
    await getDataFromLocal();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getData(context);




    // if(currentUser.id == null || currentUser.id == ""){
    //   InheritedObjects.of(context).bodyWidget.setCurrentTab(3);
    // }else{
    //   InheritedObjects.of(context).user.updateCurrentUser(currentUser);
    // }

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        int tabID = InheritedObjects.of(context).bodyWidget.currentBody;
        if ([1,2,3,4,5,6,7,8,9].contains(tabID)) {
          Utils.backToLastTab(context);
        } else{
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder<int>(
          stream: InheritedObjects.of(context).bodyWidget.myStream,
//          future: getData(context),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//            Widget body = BodyWidgetInherited.of(context).bodyWidget.currentBody == null? MyDiaryScreen(animationController: animationController):  BodyWidgetInherited.of(context).bodyWidget.currentBody ;
            Widget body;

            int tabID = InheritedObjects.of(context).bodyWidget.currentBody;

            // User user = InheritedObjects.of(context).user.currentUser;
            // if(user.id == null || user.id == ""){
              // User u = new User(id: 'abcxyz', name: "PHẠM VIỆT ANH", address: "303 ShynDongBil", phone: "01086820000", org_cd: "001", org_nm: "Hagidong");
              // InheritedObjects.of(context).user.updateCurrentUser(u);
              // tabID = 3;
             // }

            if (tabID == 0) {
              body = UserScreen(animationController: animationController);
            } else if (tabID == 1) {
              body = HomeScreen(animationController: animationController);
            // } else if (tabID == 7) {
            //   body = AboutUsScreen(animationController: animationController);
            // } else if (tabID == 3) {
            //   body = QRScreen(animationController: animationController);
            // } else if (tabID == 2) {
            //   body = SuggestionScreen(animationController: animationController);
            // } else if (tabID == 1) {
            //   body = TopDishesScreen(animationController: animationController);
            } else {
              body = QRScreen(animationController: animationController);
            }

            return Stack(
              children: <Widget>[
                body,
                bottomBar(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<bool> getData(BuildContext context) async {
//    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  setDataToLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id','abcxyz');
    prefs.setString('name', "PHẠM VIỆT ANH");
    prefs.setString('phone', "01086820000");
    prefs.setString('address', "303 ShynDongBil");
    prefs.setString('org_cd', "001");
    prefs.setString('org_nm', "Hagidong");

  }

  getDataFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // currentUser.id = await prefs.getString('id');
    // currentUser.name = await prefs.getString('name');
    // currentUser.phone = await prefs.getString('phone');
    // currentUser.address = await prefs.getString('address');
    // currentUser.org_cd = await prefs.getString('org_cd');
    // currentUser.org_nm = await prefs.getString('org_nm');

    // setState(() {
    //   InheritedObjects.of(context).user.updateCurrentUser(currentUser);
    // });
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Column(
                  children: <Widget>[Text("abc")],
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget bottomBar(BuildContext context) {
    List<TabIconData> tabIconsList =
        InheritedObjects.of(context).listTab.currentListTab;

    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
//            BodyWidgetInherited.of(context).bodyWidget.setCurrentTab(index);
            Utils.updateTabIndex(context, index);
            animationController.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
            });
          },
        ),
      ],
    );
  }
}
