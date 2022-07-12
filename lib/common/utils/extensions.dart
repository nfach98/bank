import 'package:flutter/material.dart';

extension ListSpaceBetweenExtension on List<Widget> {
  List<Widget> withSpaceBetween({double? width, double? height}) => [
        for (int i = 0; i < length; i++) ...[
          if (i > 0) SizedBox(width: width, height: height),
          this[i],
        ],
      ];
}

extension ValidationExtension on String {
  bool get isValidEmail => RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      ).hasMatch(this);

  bool get isValidPhone => RegExp(r'(^(?:[0-9]){10,12}$)').hasMatch(this);

  bool get isPasswordLengthValid =>
      RegExp(r'^[a-zA-Z0-9!@#$%].{7,19}$').hasMatch(this);

  bool get isContainsNumberAndSymbol =>
      RegExp(r'^(?=.*[0-9])(?=.*[!@#\$%])').hasMatch(this);

  bool get isContainsCharacter => RegExp(r'^(?=.*[a-zA-Z])').hasMatch(this);
}

// Media Query extensions
extension Media on BuildContext {
  MediaQueryData get media {
    return MediaQuery.of(this);
  }

  double get statusBarHeight {
    return media.padding.top;
  }

  double get screenWidth {
    return media.size.width;
  }

  double get screenHeight {
    return media.size.height;
  }

  double get finalHeight {
    return media.size.height - statusBarHeight;
  }
}

extension FormatColor on String {
  Color parseColor() {
    return Color(int.parse(replaceFirst('#', '0xff')));
  }
}

extension ColorExt on Color {
  String toStringColor() {
    return "#" + toString().split('(0xff')[1].split(')')[0];
  }
}
