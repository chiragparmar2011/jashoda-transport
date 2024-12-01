import 'package:flutter/material.dart';

class MyGlobals {
  factory MyGlobals() {
    return _myGlobals;
  }

  MyGlobals._internal();

  static final MyGlobals _myGlobals = MyGlobals._internal();

  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
}