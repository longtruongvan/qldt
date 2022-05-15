import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SystemManagerMainState {
  RxInt itemSelected = 0.obs;
  late PageController pageController;

  SystemManagerMainState() {
    pageController = PageController(initialPage: 0);
  }
}
