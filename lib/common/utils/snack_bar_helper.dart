import 'package:flutter/material.dart';

class SnackBarHelper {
  SnackBarHelper._();

  static show({required BuildContext context, String? content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content ?? ''),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}