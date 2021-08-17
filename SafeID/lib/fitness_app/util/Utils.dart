


import 'package:SafeID/fitness_app/models/dish.dart';
import 'package:SafeID/fitness_app/models/tabIcon_data.dart';
import 'package:flutter/material.dart';

import '../InheritedModel/InheritedObject.dart';
import 'api.dart';

class Utils{

  static Future<List<String>> getListFilteredByKeyword(String pattern) async {
    return await API.getListFilteredByKeyword({'KEYWORD': pattern});
  }


  static void doLike(String like){
    API.doLike({'like': like});
  }
  //
  // static void updateTopList(BuildContext context){
  //   API.getListTopPublic().then((res) {
  //     InheritedObjects.of(context).listTop.updateListTop(res);
  //   });
  // }
  //
  // static void updateRandomList(BuildContext context){
  //   API.getListRandomPublic().then((res) {
  //     InheritedObjects.of(context).listRandom.updateListRandom(res);
  //   });
  // }
  //
  // static void updateCurrentDish(BuildContext context, String id){
  //   API.getDishById({'DISH_UID': id}).then((res) {
  //     InheritedObjects.of(context).dish.updateCurrentDish(res);
  //   });
  // }


  static void updateTabIndex(BuildContext context, int index){
    InheritedObjects.of(context).bodyWidget.setCurrentTab(index);
    List<TabIconData> tabIconsList = InheritedObjects.of(context).listTab.currentListTab;
    List<TabIconData> clone = new List<TabIconData>.from(tabIconsList);

    for(int i = 0; i < clone.length; i++){
      clone[i].isSelected = false;
      if(i == index){
        clone[i].isSelected = true;
      }
    }
    InheritedObjects.of(context).listTab.updateTab(clone);
  }

  static void backToLastTab(BuildContext context){
    int index = InheritedObjects.of(context).bodyWidget.backLastTab();
    List<TabIconData> tabIconsList = InheritedObjects.of(context).listTab.currentListTab;
    List<TabIconData> clone = new List<TabIconData>.from(tabIconsList);

    for(int i = 0; i < clone.length; i++){
      clone[i].isSelected = false;
      if(i == index){
        clone[i].isSelected = true;
      }
    }
    InheritedObjects.of(context).listTab.updateTab(clone);
  }

}

