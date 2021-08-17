import 'package:rxdart/rxdart.dart';

class BodyWidget {
    int _currentBody;
    List<int> _treeTab = [0];

    int get currentBody => _currentBody;

//    BodyWidget(
//        this._currentId);
    BehaviorSubject<int> _tabSubject = BehaviorSubject<int>();
    Stream<int> get myStream => _tabSubject.stream;

    BodyWidget() {
        _tabSubject.listen((item)  {
            _currentBody = item;
        });
    }

    void setCurrentTab(int id) {
        _treeTab.add(id);
        this._tabSubject.add(id);
    }

    int backLastTab() {
        int id = 0;
        if(_treeTab.length > 1){
            _treeTab.removeLast();
            id = _treeTab.last;
            this._tabSubject.add(id);
        }else{
            this._tabSubject.add(id);
        }
        return id;
    }
}