import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/size_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:SafeID/fitness_app/app_theme.dart';
import 'package:SafeID/fitness_app/common_models/LanguageMap.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SuggestionIntroView extends StatefulWidget {
  const SuggestionIntroView({Key key, this.animationController, this.animation})
      : super(key: key);
  final AnimationController animationController;
  final Animation animation;
  @override
  _SuggestionIntroViewState createState() => _SuggestionIntroViewState();
}

class _SuggestionIntroViewState extends State<SuggestionIntroView>
    with TickerProviderStateMixin {
  List<Widget> listImage = <Widget>[
    Image.asset('assets/fitness_app/manual_make/search.png'),
    Image.asset('assets/fitness_app/manual_make/cookbook.png'),
    Image.asset('assets/fitness_app/manual_make/idea2.png'),
  ];
  Widget seaching, imagePump, imageMeat, imageArrow1, imageArrow2, imageDish;
  Timer _timer;
  int index;

  @override
  void initState() {
    // TODO: implement initState
    // seaching = imageBox(Image.asset('assets/fitness_app/manual_make/cookbook.png'), false);
    imagePump =
        foodBox(Image.asset('assets/fitness_app/manual_make/pumkin.png'));
    seaching = imageBox(Container(), true);
    imageMeat = foodBox(Container());
    imageArrow1 = arrowBox(Container(), true);
    imageArrow2 = arrowBox(Container(), true);
    imageDish = imageBox(Container(), false);

    index = 0;
    print(index);
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      index = index > 20 ? 0 : index + 1;
      setState(() {
        if (index == 0) {
          imagePump =
              foodBox(Image.asset('assets/fitness_app/manual_make/pumkin.png'));
        } else if (index == 1) {
          imageMeat =
              foodBox(Image.asset('assets/fitness_app/manual_make/meat.png'));
        } else if (index == 2) {
          seaching = imageBox(
              Image.asset('assets/fitness_app/manual_make/secret.png'), true);
        } else if (index == 3) {
          imageArrow1 =
              arrowBox(Image.asset('assets/fitness_app/arrow3.png'), true);
        } else if (index == 4) {
          seaching =
              imageBox(Image.asset('assets/fitness_app/manual_make/smartphone.png'), true);
        } else if (index == 5) {

        } else if (index == 7) {
          seaching = searchBox(
              Image.asset('assets/fitness_app/manual_make/search2.png'));
        } else if (index == 9) {

        } else if (index == 10) {
          seaching =
              ideaBox(Image.asset('assets/fitness_app/idea3.png'));
        } else if (index == 12) {
          imageArrow2 = arrowBox(Image.asset('assets/fitness_app/arrow3.png'), true);
        } else if (index == 14) {
          imageDish = imageBox(Image.asset('assets/fitness_app/manual_make/dish1.png'), false);
        } else if (index == 16) {
          seaching = imageBox(Container(), true);
          imageMeat = foodBox(Container());
          imagePump = foodBox(Container());
          imageArrow1 = arrowBox(Container(), true);
          imageArrow2 = arrowBox(Container(), true);
          imageDish = imageBox(Container(), false);
        }
      });
      // print(index);
    });
    /*_timer = Timer.periodic(Duration(seconds: 1), (Timer t) => (){
      index = index >= listImage.length - 1? 0: index++;
      print(index);
    });*/
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

/*  void change(){
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) => (){
      index = index >= listImage.length - 1? 0: index++;
      setState(() {
        seaching = imageProgress(listImage[index]);
      });
    });
  }*/

  Widget ideaBox(Widget image) {
    return SizeAnimatedWidget(
      enabled: true,
      duration: Duration(milliseconds: 500),
      values: [Size(60, 60), Size(80, 80), Size(70, 70), Size(60, 60)],
      curve: Curves.linear,
      child: image,
    );
  }

  Widget foodBox(Widget image) {
    return ShakeAnimatedWidget(
        enabled: true,
        duration: Duration(milliseconds: 1500),
        shakeAngle: Rotation.deg(z: 40),
        curve: Curves.linear,
        child: SizedBox(width: 80, height: 80, child: image));
  }

  Widget secretBox(Widget image) {
    return ShakeAnimatedWidget(
        enabled: true,
        duration: Duration(milliseconds: 1500),
        shakeAngle: Rotation.deg(z: 40),
        curve: Curves.linear,
        child: SizedBox(width: 80, height: 80, child: image));
  }

  Widget searchBox(Widget image) {
    return SizedBox(
        width: 80,
        height: 80,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: TranslationAnimatedWidget(
                enabled: true, //will forward/reverse the animation
                curve: Curves.linear,
                duration: Duration(seconds: 3),
                values: [
                  Offset(0, 2),
                  Offset(0, 4),
                  Offset(2, 6),
                  Offset(4, 6),
                  Offset(6, 4),
                  Offset(6, 2),
                  Offset(4, 0),
                  Offset(2, 0),
                  Offset(0, 2),
                  Offset(0, 4),
                  Offset(2, 6),
                  Offset(4, 6),
                  Offset(6, 4),
                  Offset(6, 2),
                  Offset(4, 0),
                  Offset(2, 0),
                  Offset(0, 2),
                  Offset(0, 4),
                  Offset(2, 6),
                  Offset(4, 6),
                  Offset(6, 4),
                  Offset(6, 2),
                  Offset(4, 0),
                  Offset(2, 0),
                ],
                child: SizedBox(width: 40, height: 40, child: image),
              ),
            ),
          ],
        ));
  }

  Widget imageBox(Widget image, bool small) {
    bool _visible = true;
    return AnimatedOpacity(
      // If the widget is visible, animate to 0.0 (invisible).
      // If the widget is hidden, animate to 1.0 (fully visible).
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      // The green box must be a child of the AnimatedOpacity widget.
      child: SizedBox(
        width: small ? 40 : 80,
        height: small ? 40 : 80,
        child: image,
      ),
    );
  }

  Widget arrowBox(Widget image, bool small) {
    bool _visible = true;
    return AnimatedOpacity(
      // If the widget is visible, animate to 0.0 (invisible).
      // If the widget is hidden, animate to 1.0 (fully visible).
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      // The green box must be a child of the AnimatedOpacity widget.
      child: SizedBox(
        width: 30,
        height: 30,
        child: image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.lightCyan,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 16, right: 16),
                      child:
                      SizedBox(
                          width: 360.0,
                          height: 170.0,
                      child: OverflowBox(
                          minWidth: 0.0,
                          maxWidth: 365.0,
                          minHeight: 0.0,
                          maxHeight: 170.0,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    imagePump,
                                    imageMeat,
                                  ],
                                ),
                                imageArrow1,
                                seaching,
                                imageArrow2,
                                imageDish,
                              ]),
                        )
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 0, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppTheme.darkCyan,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, top: 8, bottom: 16),
                        child: Container(
                          child: Text(
                              LanguageMap.getValue("main.suggestion_title"),
                              style: TextStyle(
                                color: AppTheme.darkText,
                                fontSize: 16
                              ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CurvePainter extends CustomPainter {
  final double angle;
  final List<Color> colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = List<Color>();
    if (colors != null) {
      colorsList = colors;
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
