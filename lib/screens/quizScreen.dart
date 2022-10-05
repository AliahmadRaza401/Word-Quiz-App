import 'dart:developer';

import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:qapp/providers/home_provider.dart';
import 'package:qapp/utils/app_colors.dart';

import '../widgets/app_text_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int indexVal = 0;
  final loveEmojis = Emoji.byKeyword('love');
  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: true);

    var valute = ((3 / (homeProvider.wordList.length)) * 100);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Q"),
        centerTitle: true,
        actions: [],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: LinearPercentIndicator(
              barRadius: Radius.circular(15.r),
              width: 320.w,
              lineHeight: 14.0,
              percent: ((2 / (homeProvider.wordList.length)) * 100) / 100,
              center: Text(
                "${((2 / (homeProvider.wordList.length)) * 100).toStringAsFixed(1)}%",
                style: const TextStyle(fontSize: 12.0),
              ),
              trailing: valute < 50
                  ? Text('\u{1F62D}')
                  : valute < 60
                      ? Text('\u{1F625}')
                      : valute < 70
                          ? Text('\u{1F619}')
                          : valute < 80
                              ? Text('\u{1F618}')
                              : valute < 90
                                  ? Text('\u{1F929}')
                                  : valute == 100
                                      ? Text('\u{1F970}')
                                      : SizedBox(),
              // ignore: deprecated_member_use
              // linearStrokeCap: LinearStrokeCap.round,

              backgroundColor: Colors.grey,
              progressColor: AppColors.primaryColor,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.center,
            child: text(
              // text: homeProvider.wordList[i],
              text: homeProvider.wordList[indexVal].words!,
              size: 35.sp,
              color: AppColors.darkBlackColor,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  log('uniqueId = ${homeProvider.wordList[indexVal].uniqueId}');
                  log('userAnser = ${homeProvider.wordList[indexVal].userAnser}');
                  log('words = ${homeProvider.wordList[indexVal].words}');
                  log('wordSugestionVal = ${homeProvider.wordList[indexVal].wordSugestionVal}');
                  log('wordsActualAnswer = ${homeProvider.wordList[indexVal].wordsActualAnswer}');

                  if (indexVal == homeProvider.wordList.length - 1) {
                    log('Limit Reach');
                  } else {
                    setState(() {
                      indexVal++;
                    });
                  }
                },
                child: correctWidget(),
              ),
              InkWell(
                onTap: () {
                  log('uniqueId = ${homeProvider.wordList[indexVal].uniqueId}');
                  log('userAnser = ${homeProvider.wordList[indexVal].userAnser}');
                  log('words = ${homeProvider.wordList[indexVal].words}');
                  log('wordSugestionVal = ${homeProvider.wordList[indexVal].wordSugestionVal}');
                  log('wordsActualAnswer = ${homeProvider.wordList[indexVal].wordsActualAnswer}');
                  if (indexVal == homeProvider.wordList.length - 1) {
                    log('Limit Reach');
                  } else {
                    setState(() {
                      indexVal++;
                    });
                  }
                },
                child: wrongWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget correctWidget() {
    return Container(
      width: 70.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        // color: Colors.amber,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Align(
        alignment: Alignment.center,
        child: text(
          text: "Correct",
          size: 16.sp,
        ),
      ),
    );
  }

  Widget wrongWidget() {
    return Container(
      width: 70.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Align(
        alignment: Alignment.center,
        child: text(
          text: "Wrong",
          size: 16.sp,
        ),
      ),
    );
  }
}
