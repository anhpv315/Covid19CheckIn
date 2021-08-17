import 'package:SafeID/fitness_app/models/dish.dart';
import 'package:SafeID/fitness_app/models/food.dart';
import 'package:SafeID/fitness_app/models/tabIcon_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ListFoodsResult {
  List<Food>  _currentListFoodsResult = [];

  List<Food> get currentListFoodsResult => _currentListFoodsResult;

  BehaviorSubject<List<Food>> _tabSubject = BehaviorSubject<List<Food>>();
  Stream<List<Food>> get myStream => _tabSubject.stream;

  ListFoodsResult() {
    _tabSubject.listen((item)  {
      _currentListFoodsResult = new List<Food>.from(item);
    });
  }

  void updateListFoodsResult(List<Food> list) {
    this._tabSubject.add(list);
  }
}