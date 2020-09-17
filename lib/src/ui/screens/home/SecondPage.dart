import 'package:flutter/material.dart';

class SecondePage extends StatefulWidget {
  @override
  _SecondePageState createState() => _SecondePageState();
}

class _SecondePageState extends State<SecondePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
        ),
        body:Column(
          children: <Widget>[
            new Container(
              height: 31.00,
              width: 38.00,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(width: 1.00, color: Color(0xff333333),), borderRadius: BorderRadius.circular(8.00),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AppColors {
  static Color get color1 => const Color(0xff95989a);

  static Color get color2 => const Color(0xff00a9de);

  static Color get color3 => const Color(0xff000000);

  static Color get color4 => const Color(0xffa2a2a2);

  static Color get color5 => const Color(0xff292929);

  static Color get color6 => const Color(0xffd5d5d5);

  static Color get color7 => const Color(0xff231f20);

  static Color get color8 => const Color(0xff353535);

  static Color get color9 => const Color(0xfffbf7ff);

  static Color get color10 => const Color(0xfff3faff);

  static Color get color11 => const Color(0xffffffff);

  static Color get color12 => const Color(0xff2c2c2c);

  static Color get color13 => const Color(0xff484848);

  static Color get color14 => const Color(0xff343434);

  static Color get color15 => const Color(0xff254f6e);
}


