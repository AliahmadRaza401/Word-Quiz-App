import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qapp/models/wordModel.dart';

class HomeProvider extends ChangeNotifier {
  late BuildContext context;

  init({required BuildContext context}) {
    this.context = context;
  }

  TextEditingController wordController = TextEditingController();
  bool booleanVal = false;
  String? wordActualAnser;
  int wrongval = 0;
  int correctVal = 0;
  List<WordModel> wordList = [];

  setButtonsColors(String boxVal) {
    if (boxVal == 'wrong') {
      correctVal = 0;
      wrongval = 1;
      booleanVal = false;
      wordActualAnser = "wrong";
    } else {
      correctVal = 1;
      wrongval = 0;
      booleanVal = true;
      wordActualAnser = "correct";
    }
    notifyListeners();
  }

  addValueinList(
    String wordofList,
    String indexId,
  ) {
    // wordList.add(wordofList);
    // log('word List Length = ${wordList.length}');

    wordList.add(
      WordModel(
        uniqueId: indexId,
        words: wordofList,
        wordSugestionVal: booleanVal,
        wordsActualAnswer: wordActualAnser!,
        userAnser: '',
      ),
    );

    log('word List Length = ${wordList.length}');
    booleanVal = false;
    wordActualAnser = '';
    wordController.clear();
    wrongval = 0;
    correctVal = 0;
    notifyListeners();
  }

  deleteValueinList(int indexVal) {
    log('word List Length Before = ${wordList.length}');
    // ignore: list_remove_unrelated_type
    wordList.removeAt(indexVal);
    log('word List Length After = ${wordList.length}');
    notifyListeners();
  }

  updateValueinList(String updateboxVal) {
    if (updateboxVal == 'wrong') {
      correctVal = 0;
      wrongval = 1;
 
    } else {
      correctVal = 1;
      wrongval = 0;

    }
    notifyListeners();

  }
}
