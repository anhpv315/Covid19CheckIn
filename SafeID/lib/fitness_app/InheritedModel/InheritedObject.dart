import 'package:safeID/fitness_app/InheritedModel/BodyWidget.dart';

import 'package:safeID/fitness_app/InheritedModel/InheritedUser.dart';
import 'package:safeID/fitness_app/InheritedModel/Keyword.dart';

import 'package:safeID/fitness_app/InheritedModel/RecentHisList.dart';
import 'package:flutter/material.dart';

import 'Lang.dart';
import 'ListTab.dart';


class InheritedObjects extends InheritedWidget {
  const InheritedObjects({
    Key key,
    @required this.bodyWidget,
    @required this.listTab,
    @required Widget child,
    this.keyword,
    this.lang,
    this.user,
    this.hisList,
    this.connected
  }) : super(key:key, child:child);
  final BodyWidget bodyWidget;
  final ListTab listTab;
  final InheritedUser user;
  final Keyword keyword;
  final Lang lang;
  final RecentHisList hisList;
  final bool connected;


  // final Food currentFood;
  // final List<Food> listSearchFoods;
  // final List<Dish> listSearchDishes;
  // final List<Food> listFoods;
  // final List<Dish> listRandom;
  // final List<Dish> listTop;
  // final List<Dish> listSuggestion;


  @override
  bool updateShouldNotify(InheritedObjects oldWidget) {
    return  true;
  }

  static InheritedObjects of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(InheritedObjects) as InheritedObjects);
  }
}