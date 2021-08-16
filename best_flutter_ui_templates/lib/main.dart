import 'dart:io';
import 'package:best_flutter_ui_templates/app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/CurrentDish.dart';
import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/CurrentFood.dart';
import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/HashTag.dart';
import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/InheritedObject.dart';
import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/InheritedUser.dart';
import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/ListDishesResult.dart';
import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/ListFood.dart';
import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/ListFoodsResult.dart';
import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/ListRandom.dart';
import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/ListSuggestion.dart';
import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/ListTab.dart';
import 'package:best_flutter_ui_templates/fitness_app/InheritedModel/RecentHisList.dart';
import 'package:best_flutter_ui_templates/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'fitness_app/InheritedModel/BodyWidget.dart';
import 'fitness_app/InheritedModel/Keyword.dart';
import 'fitness_app/InheritedModel/Lang.dart';
import 'fitness_app/main_screen.dart';
import 'fitness_app/models/historyMove.dart';
import 'fitness_app/models/user.dart';
import 'fitness_app/util/LocalStorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget body =  Container(
  color: Colors.white,
  );

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return InheritedObjects(
      bodyWidget: BodyWidget(),
      user: InheritedUser(),
      listTab: ListTab(),
      hashTag: HashTag(),
      keyword: Keyword(),
      hisList: RecentHisList(),
      lang: Lang(),
      child: MaterialApp(
        title: 'Flutter UI',
        debugShowCheckedModeBanner: false,
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          var myLocale = deviceLocale ; // here you make your app language similar to device language , but you should check whether the localization is supported by your app
//          print(myLocale.countryCode);
//          print(myLocale.languageCode);
          if(LocalStorage.localStorage.getString("lang") == null || LocalStorage.localStorage.getString("lang").isEmpty){
            switch(myLocale.languageCode){
              case 'vi':
                LocalStorage.localStorage.setString("lang", myLocale.languageCode);
                break;
              case 'ko':
                LocalStorage.localStorage.setString("lang", myLocale.languageCode);
                break;
              default:
                LocalStorage.localStorage.setString("lang", 'en');
                return;
            }
          }
          return;
        },
        theme: ThemeData(
          primarySwatch: Colors.pink[80],
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.iOS,
        ),
        home: LoadingScreen(),
      )
    );

    return MaterialApp(
      title: 'Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: MainScreen(),
    );
  }
}
