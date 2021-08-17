import 'package:best_flutter_ui_templates/fitness_app/models/food.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/tabIcon_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CurrentFood {
  Food _currentFood = new Food();

  Food get currentFood => _currentFood;

  BehaviorSubject<Food> _tabSubject = BehaviorSubject<Food>();
  Stream<Food> get myStream => _tabSubject.stream;

  CurrentFood() {
    _tabSubject.listen((item)  {
      _currentFood = item;
    });
  }

  void updateCurrentFood(Food food) {
    this._tabSubject.add(food);
  }
}