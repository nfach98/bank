import 'package:bank/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/themes.dart';

class BottomSheetHelper {
  BottomSheetHelper._();

  static show({required BuildContext context, required Widget child}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
        ),
      ),
      builder: (_) {
        return Padding(
          padding: context.media.viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: BankTheme.colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: context.media.size.width,
                      child: Center(
                        child: FractionallySizedBox(
                          widthFactor: .3,
                          child: Container(
                            height: 4.h,
                            margin: EdgeInsets.fromLTRB(
                              18.r,
                              10.r,
                              18.r,
                              18.r,
                            ),
                            decoration: BoxDecoration(
                              color: BankTheme.colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.r),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: child,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}