import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData defaults() {
    const mainFontFamily = 'Inter';

    return ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      textTheme: const TextTheme(

        headline1: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            height: 21.6 / 18,
            letterSpacing: -.02,
            fontFeatures: [
              FontFeature.enable("cv11"),
              FontFeature.enable("tnum"),
              FontFeature.enable("lnum"),
            ]
        ),
        headline2: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 17,
            height: 22 / 17,
            letterSpacing: -.01,
        ),
        headline3: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 19.2 / 16,
            fontFeatures: [
              FontFeature.enable("cv11"),
              FontFeature.enable("tnum"),
              FontFeature.enable("lnum"),
            ]
        ),
        headline4: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            height: 16.8 / 14,
            letterSpacing: .01,
            fontFeatures: [
              FontFeature.enable("cv11"),
              FontFeature.enable("tnum"),
              FontFeature.enable("lnum"),
            ]
        ),
        headline5: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 11,
            height: 14.3 / 11,
            letterSpacing: .06,
            fontFeatures: [
              FontFeature.enable("cv11"),
              FontFeature.enable("tnum"),
              FontFeature.enable("lnum"),
              FontFeature.enable("salt"),
            ]
        ) ,
        headline6: TextStyle(),
        //second subtitle in item
        subtitle1: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            height: 16.8 / 14,
            fontFeatures: [
              FontFeature.enable("cv11"),
            ]
        ),
        //folder
        subtitle2: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 14,
            height: 16.8 / 14,
            letterSpacing: -.01,
            fontFeatures: [
              FontFeature.enable("cv11"),
            ]
        ),
        //button addElement
        bodyText1: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 19.2 / 16,
            fontFeatures: [
              FontFeature.enable("cv11"),
              FontFeature.enable("tnum"),
              FontFeature.enable("lnum"),
            ]
        ),
        bodyText2:TextStyle(),
        //button2 notBorder
        button: TextStyle(
            fontFamily: mainFontFamily,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 19.2 / 16,
            fontFeatures: [
              FontFeature.enable("cv11"),
            ]
        ),
        caption: TextStyle(),
      ),
    );
  }
}