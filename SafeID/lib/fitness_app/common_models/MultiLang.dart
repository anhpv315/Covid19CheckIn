import 'package:safeID/fitness_app/InheritedModel/InheritedObject.dart';
import 'package:flutter/material.dart';
import './LanguageMap.dart';

class MultiLang extends StatefulWidget {
  const MultiLang({Key key, this.keyItem}) : super(key: key);
  final String keyItem;

  @override
  _MultiLangState createState() => _MultiLangState();
}

class _MultiLangState extends State<MultiLang> {
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
    String currentLang = InheritedObjects.of(context).lang.currentLang;
    if(currentLang == ''){
      currentLang = 'vi';
    }
    String value = LanguageMap.message[currentLang][widget.keyItem];
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 64.0, 0.0, 0.0),
        child: Container(
            child: Text(value)
            )
    );
  }
}
