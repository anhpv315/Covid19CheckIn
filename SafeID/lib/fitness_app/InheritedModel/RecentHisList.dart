import 'package:safeID/fitness_app/models/historyMove.dart';
import 'package:rxdart/rxdart.dart';

class RecentHisList {
  List<HistoryMove>  _currentRecentHisList = HistoryMove.HistTempList;

  List<HistoryMove> get currentRecentHisList => _currentRecentHisList;

  BehaviorSubject<List<HistoryMove>> _listSubject = BehaviorSubject<List<HistoryMove>>();
  Stream<List<HistoryMove>> get myStream => _listSubject.stream;

  RecentHisList() {
    _listSubject.listen((item)  {
      _currentRecentHisList = new List<HistoryMove>.from(item);
    });
  }

  void updateRecentHisList(List<HistoryMove> list) {
    this._listSubject.add(list);
  }
}