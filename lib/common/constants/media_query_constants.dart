import 'package:flutter/material.dart';

class MediaQueryConstants {
  MediaQueryConstants._();
}

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  EdgeInsets get padding => MediaQuery.of(this).padding;
}
