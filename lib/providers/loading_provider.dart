import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  late BuildContext context;

  init({required BuildContext context}) {
    this.context = context;
  }

  bool loading = false;
  int colorvalue = 1;
  setColorValue(int val) {
    colorvalue = val;
    notifyListeners();
  }
  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }
}