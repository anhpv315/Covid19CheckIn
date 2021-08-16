import 'dart:convert';


class Food {

  Food({
    this.id,
    this.name,
    this.description,
    this.fileId
  });

  String name;
  String id;
  String description;
  String fileId;

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['FOOD_ID'],
      name: json['FOOD_NM'],
      description: json['DESCR'],
      fileId: json['FILE_UID'],
    );
  }

  static List<Food> foodList = <Food>[
    Food(
      name: 'Crab',
      fileId: 'assets/fitness_app/home_s.png',
      id: 'food_0',
    ),
    Food(
      name: 'Fish',
      fileId: 'assets/fitness_app/home_s.png',
      id: 'food_1',
    ),
    Food(
      name: 'Beef',
      fileId: 'assets/fitness_app/home_s.png',
      id: 'food_2',
    ),
    Food(
      name: 'Egg',
      fileId: 'assets/fitness_app/home_s.png',
      id: 'food_3',
    ),

  ];
}
