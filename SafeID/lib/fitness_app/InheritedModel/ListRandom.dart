import 'package:SafeID/fitness_app/models/dish.dart';
import 'package:SafeID/fitness_app/models/tabIcon_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ListRandom {
  List<Dish>  _currentListRandom = Dish.randomList;

  List<Dish> get currentListRandom => _currentListRandom;

  BehaviorSubject<List<Dish>> _tabSubject = BehaviorSubject<List<Dish>>();
  Stream<List<Dish>> get myStream => _tabSubject.stream;

  ListRandom() {
    _tabSubject.listen((item)  {
      _currentListRandom = new List<Dish>.from(item);
    });
  }

  void updateListRandom(List<Dish> list) {
    this._tabSubject.add(list);
  }
}