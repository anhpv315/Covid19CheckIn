import 'package:safeID/fitness_app/app_theme.dart';
import 'package:safeID/fitness_app/main_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

import 'fitness_app/InheritedModel/InheritedObject.dart';
import 'fitness_app/models/user.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  String status = '';

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
//    status = LanguageMap.getValue("loading.check_internet");
    checkConnection();
    super.initState();
  }

  Future<void> checkConnection() async {
    var future2 = new Future.delayed(const Duration(milliseconds: 500), screenCallBack);

//    try {
//      final result = await InternetAddress.lookup('google.com');
//      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//        await new Future.delayed(const Duration(milliseconds : 10));
//        setState(() {
//          status = LanguageMap.getValue("loading.connect_server");
//        });
//        var future2 = new Future.delayed(const Duration(milliseconds: 500), screenCallBack);
//      }
//    } on SocketException catch (_) {
//      status = LanguageMap.getValue("loading.internet_failed");
//
//      var future2 = new Future.delayed(const Duration(milliseconds: 500), screenCallBack);
//    }
  }

  void screenCallBack() {
    setState(() => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          )
        });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget spinet = SpinKitThreeBounce(
      color: AppTheme.lightCyan,
      size: 30.0,
    );


    User u = new User(id: 'abcxyz', name: "PH???M VI???T ANH", address: "303 ShynDongBil", phone: "01086820000", org_cd: "001", org_nm: "Hagidong");
    InheritedObjects.of(context).user.updateCurrentUser(u);
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);

    return Container(
        color: AppTheme.darkCyan,
        child: Scaffold(
            backgroundColor: AppTheme.darkCyan,
            body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/aprotect-logo-nobg.png',
                        width: 200.0),
                    Text("Safeid", style: TextStyle(fontFamily: "Blackpast", fontSize: 20, color: AppTheme.lightGrey),),
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      child: spinet,
                    ),
                    SizedBox(height: 60),
                    Text(status, style: TextStyle(color: AppTheme.nearlyWhite),)
                  ],
                )
            )
        )
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
