import 'package:flutter/material.dart';

class TabIconData {
  
  TabIconData({
    this.icon = null,
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  IconData icon;
  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      icon: Icons.bar_chart,
      imagePath: 'assets/fitness_app/home.png',
      selectedImagePath: 'assets/fitness_app/home_s.png',
      index: 0,
      isSelected: false,
      animationController: null,
    ),
    // TabIconData(
    //   imagePath: 'assets/fitness_app/rank.png',
    //   selectedImagePath: 'assets/fitness_app/rank_s.png',
    //   index: 3,
    //   isSelected: false,
    //   animationController: null,
    // ),
    // TabIconData(
    //   imagePath: 'assets/fitness_app/idea.png',
    //   selectedImagePath: 'assets/fitness_app/idea_s.png',
    //   index: 2,
    //   isSelected: false,
    //   animationController: null,
    // ),
    TabIconData(
      icon: Icons.description,
      imagePath: 'assets/fitness_app/personal.png',
      selectedImagePath: 'assets/fitness_app/personal_s.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),

//    TabIconData(
//      imagePath: 'assets/fitness_app/setting.png',
//      selectedImagePath: 'assets/fitness_app/setting_s.png',
//      index: 3,
//      isSelected: false,
//      animationController: null,
//    ),
  ];
}
