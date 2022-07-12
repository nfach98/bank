import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankTheme {
  static final gradients = _Gradients();
  static final colors = _Colors();
  static final textStyles = _TextStyles();
  static final dimens = _Dimens();
  
  static final theme = ThemeData(
    fontFamily: 'Roboto',
    primaryColor: BankTheme.colors.green,
    accentColor: BankTheme.colors.white,
    textTheme: TextTheme(
      headline1: BankTheme.textStyles.headline1,
      headline2: BankTheme.textStyles.headline2,
      headline3: BankTheme.textStyles.headline3,
      bodyText1: BankTheme.textStyles.bodyText1,
      bodyText2: BankTheme.textStyles.bodyText2,
    ),
    appBarTheme: AppBarTheme(
      foregroundColor: BankTheme.colors.white,
      backgroundColor: BankTheme.colors.green,

    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(BankTheme.colors.green),
        foregroundColor: MaterialStateProperty.all(BankTheme.colors.white),
        textStyle: MaterialStateProperty.all(
          BankTheme.textStyles.headline3.copyWith(
            fontSize: 14.sp,
          ),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(12).r),
      ),
    ),
  );
}

class _Gradients {

}

class _Colors {
  final green = _Materialize.createMaterialColor(0xFF32C6C3);
  final white = const Color(0xffF9F9F9);
  final black = const Color(0xff2f2f2f);
  final grey = const Color(0xff919191);
}

class _TextStyles {
  final headline1 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24.sp,
    color: BankTheme.colors.black,
  );
  final headline2 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    color: BankTheme.colors.black,
  );
  final headline3 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: BankTheme.colors.black,
  );
  final bodyText1 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: BankTheme.colors.black,
  );
  final bodyText2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: BankTheme.colors.black,
  );
}

class _Dimens{
  final double searchWidgetHeight = 48.h;
  final double paddingNormal = 16.h;
  final double horizontalPaddingNormal = 16.w;
  final double horizontalPaddingLarge = 24.w;
  final double fixedHeightAppbar = 56.h;
}

class _Materialize {
  static MaterialColor createMaterialColor(int value) {
    Color color = Color(value);
    
    return MaterialColor(
        value,
      {
        50:Color.fromRGBO(color.red,color.green,color.blue, .1),
        100:Color.fromRGBO(color.red,color.green,color.blue, .2),
        200:Color.fromRGBO(color.red,color.green,color.blue, .3),
        300:Color.fromRGBO(color.red,color.green,color.blue, .4),
        400:Color.fromRGBO(color.red,color.green,color.blue, .5),
        500:Color.fromRGBO(color.red,color.green,color.blue, .6),
        600:Color.fromRGBO(color.red,color.green,color.blue, .7),
        700:Color.fromRGBO(color.red,color.green,color.blue, .8),
        800:Color.fromRGBO(color.red,color.green,color.blue, .9),
        900:Color.fromRGBO(color.red,color.green,color.blue, 1),
      }
    );
  }
}





