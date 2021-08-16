import 'package:best_flutter_ui_templates/fitness_app/models/dish.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/tabIcon_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ListDishesResult {
  List<Dish>  _currentListDishesResult = Dish.randomList;

  List<Dish> get currentListDishesResult => _currentListDishesResult;

  BehaviorSubject<List<Dish>> _tabSubject = BehaviorSubject<List<Dish>>();
  Stream<List<Dish>> get myStream => _tabSubject.stream;

  ListDishesResult() {
    _tabSubject.listen((item)  {
      _currentListDishesResult = new List<Dish>.from(item);
    });
  }

  void updateListDishesResult(List<Dish> list) {
    this._tabSubject.add(list);
  }
}