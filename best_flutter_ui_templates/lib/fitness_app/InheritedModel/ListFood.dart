import 'package:best_flutter_ui_templates/fitness_app/models/food.dart';
import 'package:rxdart/rxdart.dart';

class ListFood {
  List<Food>  _currentListFood = Food.foodList;

  List<Food> get currentListFood => _currentListFood;

  BehaviorSubject<List<Food>> _tabSubject = BehaviorSubject<List<Food>>();
  Stream<List<Food>> get myStream => _tabSubject.stream;

  ListFood() {
    _tabSubject.listen((item)  {
      _currentListFood = new List<Food>.from(item);
    });
  }

  void updateListFood(List<Food> list) {
    this._tabSubject.add(list);
  }
}