import 'dart:convert';
import 'package:best_flutter_ui_templates/fitness_app/models/dish.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/food.dart';
import 'package:best_flutter_ui_templates/fitness_app/util/config.dart';
import 'package:http/http.dart' as http;

class API {

 /*
  * dishes
  */



  static Future<Map> getListSearchPublic(param) async {
    var uri = Uri.http(Config.ip, '/public/search', param);

    final response = await http.get(uri);
    String source = Utf8Decoder().convert(response.bodyBytes);

    if (response.statusCode == 200) {
      List<Dish> dishesList = new List();
      List<Food> foodsList = new List();
      json.decode(source)['DISHES'].forEach((value) => {
        dishesList.add(Dish.fromJson(value))
      });
      json.decode(source)['FOODS'].forEach((value) => {
        foodsList.add(Food.fromJson(value))
      });
      return {'DISHES': dishesList, 'FOODS': foodsList};
    } else {
      throw Exception('Failed to load dishes');
    }

    // final response = await http.get(uri);
    // if (response.statusCode == 200) {
    //   List<Dish> dishesList = new List();
    //   List<Food> foodsList = new List();
    //   jsonDecode(response.body).DISHES.forEach((value) => {
    //     dishesList.add(Dish.fromJson(value))
    //   });
    //   jsonDecode(response.body).FOODS.forEach((value) => {
    //     foodsList.add(Food.fromJson(value))
    //   });
    //   return {'DISHES': dishesList, 'FOODS': foodsList};
    // } else {
    //   throw Exception('Failed to load dishes');
    // }
  }

 static Future<List<String>> getListFilteredByKeyword(param) async {
    var uri = Uri.http(Config.ip, '/public/filteredList', param);
    final response = await http.get(uri);
    String source = Utf8Decoder().convert(response.bodyBytes);

    if (response.statusCode == 200) {
      List<String> list = new List();
      json.decode(source)['data'].forEach((value) => {
        list.add(value)
      });
      return list;
    } else {
      throw Exception('Failed to load dishes');
    }
  }

  static Future<List<String>> getListFoodByKeyword(param) async {
    var uri = Uri.http(Config.ip, '/public/getListFoodsByKeyword', param);
    final response = await http.get(uri);
    String source = Utf8Decoder().convert(response.bodyBytes);

    if (response.statusCode == 200) {
      List<String> list = new List();
      json.decode(source)['data'].forEach((value) => {
        list.add(value['FOOD_NM'].toString() + ' - ' + value['FOOD_UID'].toString())
      });
      return list;
    } else {
      throw Exception('Failed to load dishes');
    }
  }

  static getListDishesByHashTag(Map<String, String> map)async {
    var uri = Uri.http(Config.ip, '/public/getDishesByHashtag', map);
    final response = await http.get(uri);
    String source = Utf8Decoder().convert(response.bodyBytes);

    if (response.statusCode == 200) {
      List<Dish> dishesList = new List();
      json.decode(source)['TAG'].forEach((value) => {
        dishesList.add(Dish.fromJson(value))
      });
      return dishesList;
    } else {
      throw Exception('Failed to load dishes');
    }
  }

  static Future<List<Dish>> getListTopPublic() async {
    var uri = Uri.http(Config.ip, '/public/getTop5', {});
    final response = await http.get(uri);
    String source = Utf8Decoder().convert(response.bodyBytes);

    if (response.statusCode == 200) {
      List<Dish> dishesList = new List();
      json.decode(source)['data'].forEach((value) => {
        dishesList.add(Dish.fromJson(value))
      });
      return dishesList;
    } else {
      throw Exception('Failed to load dishes');
    }
  }

  static Future<List<Dish>> getListRandomPublic() async {
    var uri = Uri.http(Config.ip, '/public/getRandomList', {});
    final response = await http.get(uri);
    String source = Utf8Decoder().convert(response.bodyBytes);

    if (response.statusCode == 200) {
      List<Dish> dishesList = new List();
      json.decode(source)['data'].forEach((value) => {
        dishesList.add(Dish.fromJson(value))
      });
      return dishesList;
    } else {
      throw Exception('Failed to load dishes');
    }
  }

  Future<List<Dish>> getListFoodsByKeyword(param) async {
    var uri = Uri.http(Config.ip, '/public/getListFoodsByKeyword', param);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<Dish> dishesList = new List();
      jsonDecode(response.body).forEach((value) => {
        dishesList.add(Dish.fromJson(value))
      });
      return dishesList;
    } else {
      throw Exception('Failed to load dishes');
    }
  }

  Future<List<Dish>> getListDishesByHashtagPublic(param) async {
    var uri = Uri.http(Config.ip, '/public/getDishesByHashtag', param);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<Dish> dishesList = new List();
      jsonDecode(response.body).forEach((value) => {
        dishesList.add(Dish.fromJson(value))
      });
      return dishesList;
    } else {
      throw Exception('Failed to load dishes');
    }
  }

  static Future<List<Dish>> getListSuggestionPublic(param) async {
    var uri = Uri.http(Config.ip, '/public/getSuggestionList', param);
    final response = await http.get(uri);
    String source = Utf8Decoder().convert(response.bodyBytes);

    if (response.statusCode == 200) {
      List<Dish> dishesList = new List();
      json.decode(source)['data'].forEach((value) => {
        dishesList.add(Dish.fromJson(value))
      });
      return dishesList;
    } else {
      throw Exception('Failed to load dishes');
    }

    // var uri = Uri.http(Config.ip, '/public/getSuggestionList', param);
    // final response = await http.get(uri);
    // if (response.statusCode == 200) {
    //   List<Dish> dishesList = new List();
    //   jsonDecode(response.body).forEach((value) => {
    //     dishesList.add(Dish.fromJson(value))
    //   });
    //   return dishesList;
    // } else {
    //   throw Exception('Failed to load dishes');
    // }
  }

  static Future<Dish> getDishById(param) async {
    var uri = Uri.http(Config.ip, '/public/getDish', param);
    final response = await http.get(uri);
    String source = Utf8Decoder().convert(response.bodyBytes);
    if (response.statusCode == 200) {
      Dish dish = new Dish();
//      print(json.decode(source)['data']);
      dish = Dish.fromJson(json.decode(source)['data']);
      return dish;
    } else {
      throw Exception('Failed to load dishes');
    }
  }


 /*
 * foods
 */
  Future<List<Food>> getListFoodsPublic(param) async {
    var uri = Uri.http(Config.ip, '/public/foods', param);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      List<Food> foodsList = new List();
      jsonDecode(response.body).forEach((value) => {
        foodsList.add(Food.fromJson(value))
      });
      return foodsList;
    } else {
      throw Exception('Failed to load foods');
    }
  }

  Future<Food> getFoodById(param) async {
    var uri = Uri.http(Config.ip, '/public/getFood', param);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return Food.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load food');
    }
  }


  /*
  * common
  */
  Future<List> getViewCount(param) async {
    var uri = Uri.http(Config.ip, '/public/getViewCount', param);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load view count');
    }
  }

  Future<void> viewPage(param) async {
    var uri = Uri.http(Config.ip, '/public/viewPage', param);
    final response = await http.post(uri);
    if (response.statusCode == 200) {
//      jsonDecode(response.body);
    } else {
      throw Exception('Failed to update view page');
    }
  }

  Future<void> viewDish(param) async {
    var uri = Uri.http(Config.ip, '/public/viewDish', param);
    final response = await http.post(uri);
    if (response.statusCode == 200) {
//      jsonDecode(response.body);
    } else {
      throw Exception('Failed to update view dish');
    }
  }

  static void doLike(param) async {
    var uri = Uri.http(Config.ip, '/public/doLike', param);
    final response = await http.post(uri);
    String source = Utf8Decoder().convert(response.bodyBytes);

    if (response.statusCode == 200) {
      // print('liked');

    } else {
      throw Exception('Failed to load dishes');
    }
  }

}