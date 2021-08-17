import 'package:SafeID/fitness_app/InheritedModel/BodyWidget.dart';
import 'package:SafeID/fitness_app/InheritedModel/CurrentDish.dart';
import 'package:SafeID/fitness_app/InheritedModel/HashTag.dart';
import 'package:SafeID/fitness_app/InheritedModel/InheritedUser.dart';
import 'package:SafeID/fitness_app/InheritedModel/Keyword.dart';
import 'package:SafeID/fitness_app/InheritedModel/ListDishesResult.dart';
import 'package:SafeID/fitness_app/InheritedModel/ListFood.dart';
import 'package:SafeID/fitness_app/InheritedModel/ListFoodsResult.dart';
import 'package:SafeID/fitness_app/InheritedModel/ListRandom.dart';
import 'package:SafeID/fitness_app/InheritedModel/ListSuggestion.dart';
import 'package:SafeID/fitness_app/InheritedModel/RecentHisList.dart';
import 'package:SafeID/fitness_app/models/dish.dart';
import 'package:SafeID/fitness_app/models/food.dart';
import 'package:flutter/material.dart';

import 'CurrentFood.dart';
import 'Lang.dart';
import 'ListTab.dart';


class InheritedObjects extends InheritedWidget {
  const InheritedObjects({
    Key key,
    @required this.bodyWidget,
    @required this.listTab,
    @required Widget child,
    this.hashTag,
    this.keyword,
    this.lang,
    this.user,
    this.hisList
  }) : super(key:key, child:child);
  final BodyWidget bodyWidget;
  final ListTab listTab;
  final InheritedUser user;
  final HashTag hashTag;
  final Keyword keyword;
  final Lang lang;
  final RecentHisList hisList;


  @override
  bool updateShouldNotify(InheritedObjects oldWidget) {
    return  true;
  }

  static InheritedObjects of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritedObjects>() as InheritedObjects);
  }
}