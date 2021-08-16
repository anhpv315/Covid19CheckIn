import 'package:rxdart/rxdart.dart';

class Lang {
  String  _currentLang = '';

  String get currentLang => _currentLang;

  BehaviorSubject<String> _langSubject = BehaviorSubject<String>();
  Stream<String> get myStream => _langSubject.stream;

  Lang() {
    _langSubject.listen((item)  {
      _currentLang = item;
    });
  }

  void updateLang(String keyword) {
    this._langSubject.add(keyword);
  }
}