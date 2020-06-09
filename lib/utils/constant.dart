import 'package:flutter/material.dart';

class Constant{
  static String apiKey = 'ce16f7da30a47ba16d9f038d895318bd';
  static String language = 'ko-KR';
  static String region = 'KR';
  static String imageUrl= 'https://image.tmdb.org/t/p/w500/';
  static String youTubeUrl= 'https://www.youtube.com/watch?v=';

  static Color mainOneColor = Color(0xffe9f2f6);
  static Color mainTwoColor = Color(0xfffafcff);
  static Color mainThreeColor = Color(0xffffce33);
  static Color mainFourColor = Color(0xff0e1116);
  static Color mainFiveColor = Color(0xff0d1321);

  static double borderRadius = 30;
  static double cardBorderRadius = 20;
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  static double s0;
  static double s1;
  static double s2;
  static double s3;
  static double s4;
  static double s5;
  static double s6;
  static double s7;
  static double s8;
  static double s9;
  static double s10;
  static double s11;
  static double s12;
  static double s13;
  static double s14;
  static double s15;
  static double s16;
  static double s17;
  static double s18;
  static double s19;
  static double s20;
  static double s21;
  static double s22;
  static double s23;
  static double s24;
  static double s25;
  static double s26;
  static double s27;
  static double s28;
  static double s29;
  static double s30;
  static double s31;
  static double s32;
  static double s33;
  static double s34;
  static double s35;
  static double s36;
  static double s37;
  static double s38;
  static double s39;
  static double s40;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    if (_mediaQueryData != null) {
      screenWidth = _mediaQueryData.size.width;
      screenHeight = _mediaQueryData.size.height;
      blockSizeHorizontal = screenWidth / 100;
      blockSizeVertical = screenHeight / 100;

      _safeAreaHorizontal =
          _mediaQueryData.padding.left + _mediaQueryData.padding.right;
      _safeAreaVertical =
          _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
      safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
      safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

      s0 = blockSizeVertical * 1.0;
      s1 = blockSizeVertical * 1.1;
      s2 = blockSizeVertical * 1.2;
      s3 = blockSizeVertical * 1.3;
      s4 = blockSizeVertical * 1.4;
      s5 = blockSizeVertical * 1.5;
      s6 = blockSizeVertical * 1.6;
      s7 = blockSizeVertical * 1.7;
      s8 = blockSizeVertical * 1.8;
      s9 = blockSizeVertical * 1.9;
      s10 = blockSizeVertical * 2.0;
      s11 = blockSizeVertical * 2.1;
      s12 = blockSizeVertical * 2.2;
      s13 = blockSizeVertical * 2.3;
      s14 = blockSizeVertical * 2.4;
      s15 = blockSizeVertical * 2.5;
      s16 = blockSizeVertical * 2.6;
      s17 = blockSizeVertical * 2.7;
      s18 = blockSizeVertical * 2.8;
      s19 = blockSizeVertical * 2.9;
      s20 = blockSizeVertical * 3.0;
      s21 = blockSizeVertical * 3.1;
      s22 = blockSizeVertical * 3.2;
      s23 = blockSizeVertical * 3.3;
      s24 = blockSizeVertical * 3.4;
      s25 = blockSizeVertical * 3.5;
      s26 = blockSizeVertical * 3.6;
      s27 = blockSizeVertical * 3.7;
      s28 = blockSizeVertical * 3.8;
      s29 = blockSizeVertical * 3.9;
      s30 = blockSizeVertical * 4.0;
      s31 = blockSizeVertical * 4.1;
      s32 = blockSizeVertical * 4.2;
      s33 = blockSizeVertical * 4.3;
      s34 = blockSizeVertical * 4.4;
      s35 = blockSizeVertical * 4.5;
      s36 = blockSizeVertical * 4.6;
      s37 = blockSizeVertical * 4.7;
      s38 = blockSizeVertical * 4.8;
      s39 = blockSizeVertical * 4.9;
      s40 = blockSizeVertical * 5.0;
    }
  }
}