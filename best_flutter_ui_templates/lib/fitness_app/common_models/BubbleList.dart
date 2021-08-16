import 'package:flutter/material.dart';
import '../../app_theme.dart';

class BubbleList extends StatefulWidget {
  const BubbleList(
      {Key key, this.listSelectedFood})
      : super(key: key);
  final List<Map> listSelectedFood;

  @override
  _BubbleListState createState() => _BubbleListState();
}

class _BubbleListState extends State<BubbleList>  {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 64.0, 0.0, 0.0),
        child: Container(
            child:
            new ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.listSelectedFood.length,
                itemBuilder: (BuildContext context, int index) {
                  return BubbleItem(food: widget.listSelectedFood[index]);
                }
            )
//                                    Text(selected == null ? '': selected)
        )
    );
  }
}

class BubbleItem extends StatelessWidget {
  const BubbleItem(
      {Key key,
        this.food
      })
      : super(key: key);
  final Map food;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: AppTheme.pink),
      child: Text(food['FOOD_NM'].toString(), style: TextStyle(color: AppTheme.white),),
    );
  }


}