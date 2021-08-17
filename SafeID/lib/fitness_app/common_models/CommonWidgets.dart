import 'package:flutter/material.dart';

import '../app_theme.dart';

class CommonWidgets{

  static Widget normalTitle(String titleTxt){
    return Container(
        child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    titleTxt,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      letterSpacing: 0.5,
                      color: AppTheme.darkText,
                    ),
                  ),
                )
              ],
            )
        )
    );
  }

  static Widget simpleTitle(String titleTxt){
    return Container(
        child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    titleTxt.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      letterSpacing: 0.5,
                      color: AppTheme.darkText,
                    ),
                  ),
                )
              ],
            )
        )
    );
  }

  static Widget singleTitleWithAnimation(String titleTxt, AnimationController animationController) {
    Animation animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval((1 / 9) * 0, 1.0, curve: Curves.fastOutSlowIn)));

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
              opacity: animation,
              child: new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30 * (1.0 - animation.value), 0.0),
                  child: Container(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  titleTxt.toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    letterSpacing: 0.5,
                                    color: AppTheme.darkText,
                                  ),
                                ),
                              )
                            ],
                          )
                      )
                  )
              )
          );
        });
  }

}