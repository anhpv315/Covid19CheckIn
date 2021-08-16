

class User {
  User({

    this.id,
    this.address,
    this.phone,
    this.org_cd,
    this.org_nm,
    this.name
  });

  String id;
  String address;
  String phone;
  String org_cd;
  String org_nm;
  String name;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['ID'],
        address: json['ADDR'],
        phone: json['PHONE'],
        org_cd: json['ORG_CD'],
        org_nm: json['ORG_NM'],
        name: json['NAME'],
    );
  }

  // static List<User> tabIconsList = <User>[
  //   User(
  //     imagePath: 'assets/fitness_app/breakfast.png',
  //     name: 'Breakfast',
  //     ingredients: <String>['Bread,', 'Peanut butter,', 'Apple'],
  //   ),
  //   User(
  //     imagePath: 'assets/fitness_app/lunch.png',
  //     name: 'Lunch',
  //     ingredients: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
  //   ),
  //   User(
  //     imagePath: 'assets/fitness_app/snack.png',
  //     name: 'Snack',
  //     ingredients: <String>['Recommend:', '800 kcal'],
  //   ),
  //   User(
  //     imagePath: 'assets/fitness_app/dinner.png',
  //     name: 'Dinner',
  //     ingredients: <String>['Recommend:', '703 kcal'],
  //   ),
  // ];

  static List<User> randomList = <User>[
//    User(
//      imagePath: 'assets/fitness_app/breakfast.png',
//      name: 'Cơm gà hải nam',
//      ingredients: <String>['Bread,', 'Peanut butter,', 'Apple'],
//    ),
//    User(
//      imagePath: 'assets/fitness_app/lunch.png',
//      name: 'Cá kho tộ',
//      ingredients: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
//    ),
//    User(
//      imagePath: 'assets/fitness_app/snack.png',
//      name: 'Cơm chiên dương châu',
//      ingredients: <String>['Recommend:', '800 kcal'],
//    ),
//    User(
//      imagePath: 'assets/fitness_app/dinner.png',
//      name: 'Vịt tiềm ớt hiểm',
//      ingredients: <String>['Recommend:', '703 kcal'],
//    ),
  ];

  static List<User> topList = <User>[
//    User(
//      imagePath: 'assets/fitness_app/breakfast.png',
//      name: 'Xườn xào chua ngọt',
//      ingredients: <String>['Bread,', 'Peanut butter,', 'Apple'],
//    ),
//    User(
//      imagePath: 'assets/fitness_app/lunch.png',
//      name: 'Thịt rang cháy cạnh',
//      ingredients: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
//    ),
//    User(
//      imagePath: 'assets/fitness_app/snack.png',
//      name: 'Canh chua cá hồi',
//      ingredients: <String>['Recommend:', '800 kcal'],
//    ),
//    User(
//      imagePath: 'assets/fitness_app/dinner.png',
//      name: 'Vịt om sấu',
//      ingredients: <String>['Recommend:', '703 kcal'],
//    ),
  ];

  static List<User> suggestionList = <User>[
    // User(
    //   imagePath: 'assets/fitness_app/breakfast.png',
    //   name: 'Xườn xào chua ngọt',
    //   ingredients: <String>['Bread,', 'Peanut butter,', 'Apple'],
    // ),
    // User(
    //   imagePath: 'assets/fitness_app/lunch.png',
    //   name: 'Thịt rang cháy cạnh',
    //   ingredients: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
    // ),
    // User(
    //   imagePath: 'assets/fitness_app/snack.png',
    //   name: 'Canh chua cá hồi',
    //   ingredients: <String>['Recommend:', '800 kcal'],
    // ),
    // User(
    //   imagePath: 'assets/fitness_app/dinner.png',
    //   name: 'Vịt om sấu',
    //   ingredients: <String>['Recommend:', '703 kcal'],
    // ),
  ];

  static List<User> menuList = <User>[
    // User(
    //   imagePath: 'assets/fitness_app/breakfast.png',
    //   name: 'Bánh mì',
    //   ingredients: <String>['Bread,', 'Peanut butter,', 'Apple'],
    // ),
    // User(
    //   imagePath: 'assets/fitness_app/lunch.png',
    //   name: 'Phở',
    //   ingredients: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
    // ),
    // User(
    //   imagePath: 'assets/fitness_app/snack.png',
    //   name: 'Salad',
    //   ingredients: <String>['Recommend:', '800 kcal'],
    // ),
    // User(
    //   imagePath: 'assets/fitness_app/dinner.png',
    //   name: 'BBQ',
    //   ingredients: <String>['Recommend:', '703 kcal'],
    // ),
  ];
}
