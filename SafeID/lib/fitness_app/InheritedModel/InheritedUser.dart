import 'package:SafeID/fitness_app/models/dish.dart';
import 'package:SafeID/fitness_app/models/tabIcon_data.dart';
import 'package:SafeID/fitness_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class InheritedUser {
  User _currentUser = new User();

  User get currentUser => _currentUser;

  BehaviorSubject<User> _userSubject = BehaviorSubject<User>();
  Stream<User> get myStream => _userSubject.stream;

  InheritedUser() {
    _userSubject.listen((item)  {
      _currentUser = item;
    });
  }

  void updateCurrentUser(User user) {
    this._userSubject.add(user);
  }
}