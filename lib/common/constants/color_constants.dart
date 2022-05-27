import 'package:flutter/material.dart';

class ColorConstants {
  ColorConstants._();

  static const Map<int, Color> colorPrimaryMap =
  {
    50:Color.fromRGBO(5,63,74,1),
    100:Color.fromRGBO(10,78,89,1),
    200:Color.fromRGBO(15,93,104,1),
    300:Color.fromRGBO(20,108,119,1),
    400:Color.fromRGBO(25,123,134,1),
    500:Color.fromRGBO(30,138,149,1),
    600:Color.fromRGBO(35,153,164,1),
    700:Color.fromRGBO(40,168,179,1),
    800:Color.fromRGBO(45,183,194,1),
    900:Color.fromRGBO(50,198,219,1),
  };

  static const colorPrimary = MaterialColor(0xFF32C6C3, colorPrimaryMap);

  static const colorWhite = Color(0xFFf2f2f2);
}
