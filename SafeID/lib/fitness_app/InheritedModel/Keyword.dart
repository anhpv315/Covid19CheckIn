import 'package:rxdart/rxdart.dart';

class Keyword {
  String  _currentKeyword = '';

  String get currentKeyword => _currentKeyword;

  BehaviorSubject<String> _tabSubject = BehaviorSubject<String>();
  Stream<String> get myStream => _tabSubject.stream;

  Keyword() {
    _tabSubject.listen((item)  {
      _currentKeyword = item;
    });
  }

  void updateKeyword(String keyword) {
    this._tabSubject.add(keyword);
  }
}