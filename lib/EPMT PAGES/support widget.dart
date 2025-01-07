import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppWidget{
  static TextStyle boldTextFieldStyle(){
    return TextStyle(
      color: CupertinoColors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
  static semiBoldTextFieldStyle(){
    return TextStyle(
      color: CupertinoColors.black,fontSize: 20,
      fontWeight: FontWeight.w600,
    );
  }
}