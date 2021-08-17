import 'package:SafeID/fitness_app/models/dish.dart';
import 'package:SafeID/fitness_app/models/tabIcon_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ListSuggestion {
  List<Dish>  _currentListSuggestion = Dish.suggestionList;

  List<Dish> get currentListSuggestion => _currentListSuggestion;

  BehaviorSubject<List<Dish>> _tabSubject = BehaviorSubject<List<Dish>>();
  Stream<List<Dish>> get myStream => _tabSubject.stream;

  ListSuggestion() {
    _tabSubject.listen((item)  {
      _currentListSuggestion = new List<Dish>.from(item);
    });
  }

  void updateListSuggestion(List<Dish> list) {
    this._tabSubject.add(list);
  }
}