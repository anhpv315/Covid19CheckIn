import 'package:best_flutter_ui_templates/fitness_app/models/dish.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/tabIcon_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CurrentDish {
  Dish _currentDish = new Dish();

  Dish get currentDish => _currentDish;

  BehaviorSubject<Dish> _tabSubject = BehaviorSubject<Dish>();
  Stream<Dish> get myStream => _tabSubject.stream;

  CurrentDish() {
    _tabSubject.listen((item)  {
      _currentDish = item;
    });
  }

  void updateCurrentDish(Dish dish) {
    this._tabSubject.add(dish);
  }
}