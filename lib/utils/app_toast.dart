import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

toast({required BuildContext context, required String msg}) {
  FToast().init(context);
  FToast().showToast(
      toastDuration: const Duration(seconds: 2),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 30.r),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.80),
            borderRadius: BorderRadius.circular(100.r)),
        child: Text(
          msg,
          textAlign: TextAlign.center,
          maxLines: 9,
          overflow: TextOverflow.fade,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
      ));
}