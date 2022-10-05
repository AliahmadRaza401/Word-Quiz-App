import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qapp/models/wordModel.dart';
import 'package:qapp/providers/home_provider.dart';
import 'package:qapp/screens/quizScreen.dart';
import 'package:qapp/utils/app_routes.dart';
import 'package:qapp/utils/app_toast.dart';
import 'package:qapp/widgets/app_text_widget.dart';
import 'package:uuid/uuid.dart';
import '../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Q APP"),
        centerTitle: true,
        actions: [],
      ),
      floatingActionButton: homeProvider.wordList.isEmpty
          ? const SizedBox()
          : TextButton(
              onPressed: () {
                AppRoutes.push(
                    context, PageTransitionType.fade, const QuizScreen());
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.only(
                      left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
                ),
                elevation: MaterialStateProperty.all(8),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primaryColor),
                shadowColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.onSurface),
              ),
              child: Text(
                'Start Quiz',
                style: TextStyle(
                  color: AppColors.darkBlackColor,
                  fontSize: 13.sp,
                ),
              ),
            ),
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Consumer<HomeProvider>(
                            builder: (context, prov, child) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.r, right: 15.r),
                                          child: const Icon(
                                              Icons.cancel_outlined,
                                              size: 29,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Container(
                                    width: 250.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primaryColor
                                                .withOpacity(0.4),
                                            blurRadius: 4.r,
                                            spreadRadius: 1.r,
                                            offset: const Offset(0, 0),
                                            blurStyle: BlurStyle.outer,
                                          )
                                        ]),
                                    child: Center(
                                      child: TextFormField(
                                          cursorColor: AppColors.primaryColor,
                                          controller:
                                              homeProvider.wordController,
                                          onChanged: ((value) {}),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          textInputAction: TextInputAction.done,
                                          style: TextStyle(
                                            color: AppColors.loghtBlackColor,
                                            fontFamily: 'Poppins-Light',
                                            fontSize: 14.sp,
                                          ),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 13.r,
                                                    horizontal: 15),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5.r),
                                                ),
                                                borderSide: BorderSide.none),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5.r),
                                                ),
                                                borderSide: BorderSide.none),
                                            hintText: "Add Word here...",
                                            hintStyle: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontFamily: 'Poppins-Light',
                                              fontSize: 14.sp,
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          homeProvider
                                              .setButtonsColors('correct');
                                        },
                                        child: correctWidget(),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          homeProvider
                                              .setButtonsColors('wrong');
                                        },
                                        child: wrongWidget(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (homeProvider.wordActualAnser ==
                                              null ||
                                          homeProvider
                                                  .wordActualAnser!.isEmpty &&
                                              homeProvider.wordController.text
                                                  .isEmpty) {
                                        toast(
                                            context: context,
                                            msg: "Some Field Missing");
                                      } else {
                                        var uniqueId = Uuid().v1();
                                        homeProvider.addValueinList(
                                            homeProvider.wordController.text,
                                            uniqueId);
                                        AppRoutes.pop(context);
                                      }
                                    },
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                        EdgeInsets.only(
                                            left: 20.w,
                                            right: 20.w,
                                            top: 10.h,
                                            bottom: 10.h),
                                      ),
                                      elevation: MaterialStateProperty.all(8),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColors.primaryColor),
                                      shadowColor: MaterialStateProperty.all(
                                          Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                    ),
                                    child: Text(
                                      'Add Word Into List',
                                      style: TextStyle(
                                        color: AppColors.darkBlackColor,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        );
                      });
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
                  ),
                  elevation: MaterialStateProperty.all(8),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primaryColor),
                  shadowColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.onSurface),
                ),
                child: Text(
                  'Add Word',
                  style: TextStyle(
                    color: AppColors.darkBlackColor,
                    fontSize: 13.sp,
                  ),
                ),
              )
            ],
          ),
          homeProvider.wordList.isEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 50.h),
                  child: Center(
                    child: Text(
                      "No Word Added Into List",
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 22.sp),
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeProvider.wordList.length,
                  itemBuilder: (context, i) {
                    WordModel cate = homeProvider.wordList[i];

                    return homeProvider.wordList.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 15.r),
                            child: const Text('NO Data '),
                          )
                        : Container(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            width: 260.w,
                            height: 60.h,
                            margin: EdgeInsets.only(
                                top: 10.h, left: 25.w, right: 25.w),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    log(cate.uniqueId!);
                                  },
                                  child: text(
                                      // text: homeProvider.wordList[i],
                                      text: homeProvider.wordList[i].words!,
                                      size: 22.sp,
                                      color: AppColors.darkBlackColor),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r)),
                                                child: Consumer<HomeProvider>(
                                                  builder:
                                                      (context, prov, child) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 10
                                                                            .r,
                                                                        right: 15
                                                                            .r),
                                                                child: const Icon(
                                                                    Icons
                                                                        .cancel_outlined,
                                                                    size: 29,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        Container(
                                                          width: 250.w,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.r),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: AppColors
                                                                      .primaryColor
                                                                      .withOpacity(
                                                                          0.4),
                                                                  blurRadius:
                                                                      4.r,
                                                                  spreadRadius:
                                                                      1.r,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 0),
                                                                  blurStyle:
                                                                      BlurStyle
                                                                          .outer,
                                                                )
                                                              ]),
                                                          child: Center(
                                                            child:
                                                                TextFormField(
                                                                    cursorColor:
                                                                        AppColors
                                                                            .primaryColor,
                                                                    controller: TextEditingController(
                                                                        text: homeProvider
                                                                            .wordList[
                                                                                i]
                                                                            .words),
                                                                    onChanged:
                                                                        ((value) {
                                                                      homeProvider
                                                                          .wordList[
                                                                              i]
                                                                          .words = value;
                                                                    }),
                                                                    textCapitalization:
                                                                        TextCapitalization
                                                                            .sentences,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .done,
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColors
                                                                          .loghtBlackColor,
                                                                      fontFamily:
                                                                          'Poppins-Light',
                                                                      fontSize:
                                                                          14.sp,
                                                                    ),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      contentPadding: EdgeInsets.symmetric(
                                                                          vertical: 13
                                                                              .r,
                                                                          horizontal:
                                                                              15),
                                                                      border: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(
                                                                            Radius.circular(5.r),
                                                                          ),
                                                                          borderSide: BorderSide.none),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderRadius: BorderRadius.all(
                                                                            Radius.circular(5.r),
                                                                          ),
                                                                          borderSide: BorderSide.none),
                                                                      hintText:
                                                                          "Add Word here...",
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        color: AppColors
                                                                            .primaryColor,
                                                                        fontFamily:
                                                                            'Poppins-Light',
                                                                        fontSize:
                                                                            14.sp,
                                                                      ),
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      filled:
                                                                          true,
                                                                    )),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  homeProvider
                                                                      .setButtonsColors(
                                                                          'correct');
                                                                  homeProvider
                                                                          .wordList[
                                                                              i]
                                                                          .wordsActualAnswer =
                                                                      "correct";
                                                                  homeProvider
                                                                      .wordList[
                                                                          i]
                                                                      .wordSugestionVal = true;
                                                                });
                                                              },
                                                              child:
                                                                  correctWidget(),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  homeProvider
                                                                      .setButtonsColors(
                                                                          'wrong');
                                                                  homeProvider
                                                                          .wordList[
                                                                              i]
                                                                          .wordsActualAnswer =
                                                                      "wrong";
                                                                  homeProvider
                                                                      .wordList[
                                                                          i]
                                                                      .wordSugestionVal = false;
                                                                });
                                                              },
                                                              child:
                                                                  wrongWidget(),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              log('wordsActualAnswer = ${homeProvider.wordList[i].wordsActualAnswer}');
                                                              log('wordSugestionVal = ${homeProvider.wordList[i].wordSugestionVal}');
                                                              log('word = ${homeProvider.wordList[i].words}');
                                                            });
                                                            AppRoutes.pop(
                                                                context);
                                                          },
                                                          style: ButtonStyle(
                                                            padding:
                                                                MaterialStateProperty
                                                                    .all(
                                                              EdgeInsets.only(
                                                                  left: 20.w,
                                                                  right: 20.w,
                                                                  top: 10.h,
                                                                  bottom: 10.h),
                                                            ),
                                                            elevation:
                                                                MaterialStateProperty
                                                                    .all(8),
                                                            shape:
                                                                MaterialStateProperty
                                                                    .all(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .amber),
                                                            shadowColor: MaterialStateProperty
                                                                .all(Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface),
                                                          ),
                                                          child: Text(
                                                            'Update Item',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .darkBlackColor,
                                                              fontSize: 13.sp,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                ),
                                              );
                                            });
                                      },
                                      child: Icon(Icons.edit,
                                          color: Colors.black, size: 20.sp),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        homeProvider.deleteValueinList(i);
                                      },
                                      child: Icon(Icons.delete,
                                          color: Colors.black, size: 20.sp),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                  }),
        ],
      ),
    );
  }

  Widget correctWidget() {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: true);
    return Container(
      width: 70.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: homeProvider.correctVal == 1
            ? AppColors.primaryColor
            : Colors.grey.shade400,
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
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: true);
    return Container(
      width: 70.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: homeProvider.wrongval == 1
            ? AppColors.primaryColor
            : Colors.grey.shade400,
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
