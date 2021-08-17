

class Dish {
  Dish({
    this.imagePath = '',
    this.fileId,
    this.name = '',
    this.id,
    this.description,
    this.ingredients,
    this.tag,
    this.view,
    this.diff,
    this.rate,
    this.manual,
    this.numMatch,
    this.numIng
  });

  String imagePath;
  String fileId;
  String name;
  String id;
  String description;
  String ingredients;
  String tag;
  int view;
  int diff;
  int rate;
  int numMatch;
  int numIng;
  String manual;

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      fileId: json['FILE_UID'],
      id: json['DISH_UID'],
      name: json['DISH_NM'],
      description: json['DESCR'],
      tag: json['TAG'],
      view: json['VIEW'],
      ingredients: json['INGREDIENTS'],
      diff: json['DIFF'],
      rate: json['RATE'],
      numIng: json['NUM_IGD'],
      numMatch: json['NUM_MATCH'],
      manual: json['MANUAL']
    );
  }

  // static List<Dish> tabIconsList = <Dish>[
  //   Dish(
  //     imagePath: 'assets/fitness_app/breakfast.png',
  //     name: 'Breakfast',
  //     ingredients: <String>['Bread,', 'Peanut butter,', 'Apple'],
  //   ),
  //   Dish(
  //     imagePath: 'assets/fitness_app/lunch.png',
  //     name: 'Lunch',
  //     ingredients: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
  //   ),
  //   Dish(
  //     imagePath: 'assets/fitness_app/snack.png',
  //     name: 'Snack',
  //     ingredients: <String>['Recommend:', '800 kcal'],
  //   ),
  //   Dish(
  //     imagePath: 'assets/fitness_app/dinner.png',
  //     name: 'Dinner',
  //     ingredients: <String>['Recommend:', '703 kcal'],
  //   ),
  // ];

  static List<Dish> randomList = <Dish>[
//    Dish(
//      imagePath: 'assets/fitness_app/breakfast.png',
//      name: 'Cơm gà hải nam',
//      ingredients: <String>['Bread,', 'Peanut butter,', 'Apple'],
//    ),
//    Dish(
//      imagePath: 'assets/fitness_app/lunch.png',
//      name: 'Cá kho tộ',
//      ingredients: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
//    ),
//    Dish(
//      imagePath: 'assets/fitness_app/snack.png',
//      name: 'Cơm chiên dương châu',
//      ingredients: <String>['Recommend:', '800 kcal'],
//    ),
//    Dish(
//      imagePath: 'assets/fitness_app/dinner.png',
//      name: 'Vịt tiềm ớt hiểm',
//      ingredients: <String>['Recommend:', '703 kcal'],
//    ),
  ];

  static List<Dish> topList = <Dish>[
//    Dish(
//      imagePath: 'assets/fitness_app/breakfast.png',
//      name: 'Xườn xào chua ngọt',
//      ingredients: <String>['Bread,', 'Peanut butter,', 'Apple'],
//    ),
//    Dish(
//      imagePath: 'assets/fitness_app/lunch.png',
//      name: 'Thịt rang cháy cạnh',
//      ingredients: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
//    ),
//    Dish(
//      imagePath: 'assets/fitness_app/snack.png',
//      name: 'Canh chua cá hồi',
//      ingredients: <String>['Recommend:', '800 kcal'],
//    ),
//    Dish(
//      imagePath: 'assets/fitness_app/dinner.png',
//      name: 'Vịt om sấu',
//      ingredients: <String>['Recommend:', '703 kcal'],
//    ),
  ];

  static List<Dish> suggestionList = <Dish>[
    // Dish(
    //   imagePath: 'assets/fitness_app/breakfast.png',
    //   name: 'Xườn xào chua ngọt',
    //   ingredients: <String>['Bread,', 'Peanut butter,', 'Apple'],
    // ),
    // Dish(
    //   imagePath: 'assets/fitness_app/lunch.png',
    //   name: 'Thịt rang cháy cạnh',
    //   ingredients: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
    // ),
    // Dish(
    //   imagePath: 'assets/fitness_app/snack.png',
    //   name: 'Canh chua cá hồi',
    //   ingredients: <String>['Recommend:', '800 kcal'],
    // ),
    // Dish(
    //   imagePath: 'assets/fitness_app/dinner.png',
    //   name: 'Vịt om sấu',
    //   ingredients: <String>['Recommend:', '703 kcal'],
    // ),
  ];

  static List<Dish> menuList = <Dish>[
    // Dish(
    //   imagePath: 'assets/fitness_app/breakfast.png',
    //   name: 'Bánh mì',
    //   ingredients: <String>['Bread,', 'Peanut butter,', 'Apple'],
    // ),
    // Dish(
    //   imagePath: 'assets/fitness_app/lunch.png',
    //   name: 'Phở',
    //   ingredients: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
    // ),
    // Dish(
    //   imagePath: 'assets/fitness_app/snack.png',
    //   name: 'Salad',
    //   ingredients: <String>['Recommend:', '800 kcal'],
    // ),
    // Dish(
    //   imagePath: 'assets/fitness_app/dinner.png',
    //   name: 'BBQ',
    //   ingredients: <String>['Recommend:', '703 kcal'],
    // ),
  ];
}
