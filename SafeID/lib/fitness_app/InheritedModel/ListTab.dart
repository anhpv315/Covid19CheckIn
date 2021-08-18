import 'package:safeID/fitness_app/models/tabIcon_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ListTab {
  List<TabIconData>  _currentListTab = TabIconData.tabIconsList;

  List<TabIconData> get currentListTab => _currentListTab;

  BehaviorSubject<List<TabIconData>> _tabSubject = BehaviorSubject<List<TabIconData>>();
  Stream<List<TabIconData>> get myStream => _tabSubject.stream;

  ListTab() {
    _tabSubject.listen((item)  {
      _currentListTab = new List<TabIconData>.from(item);
    });
  }

  void updateTab(List<TabIconData> list) {
    this._tabSubject.add(list);
  }
}