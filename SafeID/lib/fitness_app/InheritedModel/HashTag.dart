import 'package:SafeID/fitness_app/models/dish.dart';
import 'package:SafeID/fitness_app/models/tabIcon_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HashTag {
  String  _currentHashtag = '';

  String get currentHashtag => _currentHashtag;

  BehaviorSubject<String> _tabSubject = BehaviorSubject<String>();
  Stream<String> get myStream => _tabSubject.stream;

  HashTag() {
    _tabSubject.listen((item)  {
      _currentHashtag = item;
    });
  }

  void updateHashtag(String hashtag) {
    this._tabSubject.add(hashtag);
  }
}