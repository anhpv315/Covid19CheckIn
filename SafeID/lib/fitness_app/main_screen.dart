import 'package:safeID/fitness_app/InheritedModel/InheritedObject.dart';
import 'package:safeID/fitness_app/QRscreen.dart';
import 'package:safeID/fitness_app/about_us_screen.dart';
import 'package:safeID/fitness_app/contact_screen.dart';
import 'package:safeID/fitness_app/util/Utils.dart';
import 'package:safeID/fitness_app/models/tabIcon_data.dart';
import 'package:safeID/fitness_app/top_dishes/static_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'app_theme.dart';
import 'common_models/LanguageMap.dart';
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
        if (tabID == 1) {
          SystemNavigator.pop();
        } else if(tabID == 1){
          Utils.backToLastTab(context);
        }
//        Fluttertoast.showToast(
//            msg: LanguageMap.getValue("code.copyMsg") ,
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.CENTER,
//            timeInSecForIosWeb: 1,
//            backgroundColor: AppTheme.lightCyan,
//            textColor: Colors.white,
//            fontSize: 16.0
//        );
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
              // User u = new User(id: 'abcxyz', name: "PH???M VI???T ANH", address: "303 ShynDongBil", phone: "01086820000", org_cd: "001", org_nm: "Hagidong");
              // InheritedObjects.of(context).user.updateCurrentUser(u);
              // tabID = 3;
             // }

            if (tabID == 0) {
              body = StatisticScreen(animationController: animationController);
            } else if (tabID == 1) {
              body = HomeScreen(animationController: animationController);
             } else if (tabID == 3) {
               body = AboutUsScreen(animationController: animationController);
            } else if (tabID == 4) {
              body = ContactScreen(animationController: animationController);
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
