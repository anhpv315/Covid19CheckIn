import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/BubbleList.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/LanguageMap.dart';
import 'package:best_flutter_ui_templates/fitness_app/common_models/header.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/food.dart';
import 'package:best_flutter_ui_templates/fitness_app/util/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../app_theme.dart';


class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  double topBarOpacity = 0.0;
  final ScrollController scrollController = ScrollController();
  List<Widget> listView = <Widget>[];
  final TextEditingController _typeAheadController = TextEditingController();
  String selected = '';
  List<Map> listSelectedFoods = [];
  GlobalKey key =  new GlobalKey<AutoCompleteTextFieldState<Food>>();
  AutoCompleteTextField<Food> textField;
  Food selectedFood;
  String label;



  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    // addAllListData();
    super.initState();
  }



  void addAllListData() {
    listView = [];
    const int count = 9;
    Animation animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController,
        curve: Interval((1 / 9) * 0, 1.0, curve: Curves.fastOutSlowIn)));
    listView.add(Container());

//     listView.add(
//         AnimatedBuilder(
//             animation: widget.animationController,
//             builder: (BuildContext context, Widget child) {
//               return FadeTransition(
//                   opacity: animation,
//                   child: new Transform(
//                       transform: new Matrix4.translationValues(
//                           0.0, 30 * (1.0 - animation.value), 0.0),
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             left: 24, right: 24, top: 16, bottom: 18),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: AppTheme.lightCyan,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(8.0),
//                                 bottomLeft: Radius.circular(8.0),
//                                 bottomRight: Radius.circular(8.0),
//                                 topRight: Radius.circular(8.0)),
//                             boxShadow: <BoxShadow>[
//                               BoxShadow(
//                                   color: AppTheme.grey.withOpacity(0.2),
//                                   offset: Offset(1.1, 1.1),
//                                   blurRadius: 10.0),
//                             ],
//                           ),
//                           padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: <Widget>[
//                               // Container(
//                               //   height: 20,
//                               //   child: spinet,
//                               // ),
//                              Padding(
//                                  child: new Container(child: TypeAheadFormField(
//
//                                    textFieldConfiguration: TextFieldConfiguration(
//                                        cursorColor: AppTheme.darkCyan,
//                                        style: new TextStyle(
//                                          color: AppTheme.darkCyan,
//                                          fontSize: 20.0,
//                                          height: 1,
//                                        ),
//                                        controller: this._typeAheadController,
//                                        decoration: InputDecoration(
//                                          // border: InputBorder.none,
//                                          hintText: LanguageMap.getValue("suggestion.pick"),
//                                          fillColor: AppTheme.darkCyan,
//                                          focusColor: AppTheme.darkCyan,
//                                          hoverColor: AppTheme.darkCyan,
//                                          hintStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppTheme.darkCyan),
//                                          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                          // border: new UnderlineInputBorder(
//                                          //       borderSide: new BorderSide( width:  1.0,
//                                          //           color: FintnessAppTheme.pink
//                                          //       )
//                                          //   )
//                                          enabledBorder: UnderlineInputBorder(
//                                            borderSide: BorderSide(width: 1, color: AppTheme.darkCyan),
//                                          ),
//                                          focusedBorder: UnderlineInputBorder(
//                                            borderSide: BorderSide(width: 1, color: AppTheme.darkCyan),
//                                          ),
//                                          border: UnderlineInputBorder(
//                                            borderSide: BorderSide(width: 1, color: AppTheme.darkCyan),
//                                          ),
//                                        )
//                                    ),
//                                    suggestionsCallback: (pattern) {
//                                      if(pattern.length < 2){
//                                        return null;
//                                      }
//                                      return Utils.getListFoodByKeyword(pattern);
//                                    },
//                                    itemBuilder: (context, suggestion) {
//                                      return ListTile(
//                                        title: Text(suggestion),
//                                      );
//                                    },
//                                    transitionBuilder: (context, suggestionsBox, controller) {
//                                      return suggestionsBox;
//                                    },
//                                    onSuggestionSelected: (suggestion) {
//                                      this._typeAheadController.text = '';
//                                      // this.selected = suggestion;
//                                      // print(this.selected);
//                                      var arr = suggestion.split('-');
//                                      setState(() {
//                                        this.selected = suggestion;
//                                        this.listSelectedFoods.add({'FOOD_NM': arr[0].toString().trim(), 'FOOD_UID':  arr[1].toString().trim()});
//
//                                      });
//                                      // WidgetsBinding.instance.addPostFrameCallback((_) => setState((){
//                                      //   this.selected = suggestion;
//                                      //   listSelectedFoods.add({'FOOD_NM': arr[0].toString().trim(), 'FOOD_UID':  arr[1].toString().trim()});
//                                      // }));
//                                      // // setState(() {
//                                      //   this.selected = suggestion;
//                                      //   listSelectedFoods.add({'FOOD_NM': arr[0].toString().trim(), 'FOOD_UID':  arr[1].toString().trim()});
//                                      // });
//                                    },
//                                    validator: (value) {
//                                      if (value.isEmpty) {
//                                        return '';
//                                      }
//                                    },
//                                    onSaved: (value) => this.selected = value,
//                                  ),
//                                  ),
//                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10)),
//                               // BubbleList(listSelectedFood: this.listSelectedFoods)
//                               //     Text(selected == null? '' : selected),
//                                   Padding(
//                                       padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
//                                       child: Container(
//                                           child:
//                                           new ListView.builder(
//                                               padding: const EdgeInsets.only(
//                                                   top: 0, bottom: 0, right: 16, left: 16),
//                                               physics: const NeverScrollableScrollPhysics(),
//                                               shrinkWrap: true,
//                                               itemCount: this.listSelectedFoods.length,
//                                               itemBuilder: (BuildContext context, int index) {
//                                                 return
//                                                   GestureDetector(
//                                                       onDoubleTap: (){
//                                                         // print("Container clicked");
//                                                         setState(() {
//                                                           this.listSelectedFoods.removeAt(index);
//                                                         });
//                                                       },
//                                                       child:  Container(
//                                                           margin:  EdgeInsets.fromLTRB(0, 5, 0, 5),
//                                                           padding: EdgeInsets.all(10),
//                                                           // decoration: BoxDecoration(color: AppTheme.pink),
//                                                           child:
//                                                           Row(
//                                                             children: [
//                                                               Icon(Icons.close, color: AppTheme.darkText, size: 16,),
//                                                               Padding(padding: EdgeInsets.all(5)),
//                                                               Text(this.listSelectedFoods[index]['FOOD_NM'].toString(), style: TextStyle(color: AppTheme.darkText),),
//                                                             ],
//                                                           )
//                                                       )
//                                                   );
//
//
//
//
//                                               }
//                                           )
//                   //                                    Text(selected == null ? '': selected)
//                                       )
//                                   )
//                             ],
//                           ),
//                         ),
//                       )
//                   )
//               );
//             })
//     );
//
//     listView.add(
//         Padding(
//             padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
//             child: Container(
//               child:
//               RaisedButton(
//                 onPressed: () {
//                   var string = '';
//                   this.listSelectedFoods.forEach((el) {
//                     string += (el['FOOD_UID'] + ',');
//                  });
//                   if(string.length >1) string.substring(0, string.length - 1);
//                   Utils.updateSuggestionList(context, string);
//                   widget.animationController.reverse().then<dynamic>((data) {
//                     Utils.updateTabIndex(context, 10);
//                   });
//                 },
//                 color: AppTheme.darkCyan,
//                 child: Icon(Icons.search, color: AppTheme.white),
//               ),
// //              IconButton(icon: Icon(Icons.refresh, color: AppTheme.pink, size: 18), color: AppTheme.pink, onPressed: null)
//             )
//         )
//     );
//
//     listView.add(
//         Padding(
//         padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
//         child: Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(LanguageMap.getValue("suggestion.guide1")),
//                   Text(LanguageMap.getValue("suggestion.guide2")),
//                   Text(LanguageMap.getValue("suggestion.guide3")),
//                   Text(LanguageMap.getValue("suggestion.guide4"))
//                 ],
//               ),
//             )
//         )
//       );
    // listView.add(
    //   ListRandomColumn(
    //     mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
    //         CurvedAnimation(
    //             parent: widget.animationController,
    //             curve: Interval((1 / count) * 1, 1.0,
    //                 curve: Curves.fastOutSlowIn))),
    //     mainScreenAnimationController: widget.animationController
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    addAllListData();
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).size.height*0.12-40,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: listView.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        widget.animationController.forward();
        return listView[index];
      },
    );
  }


  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Column(
                  children: <Widget>[
                    Header(topBarOpacity: topBarOpacity, animationController: widget.animationController)
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
