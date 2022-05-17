import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentMainState{
  RxInt itemSelected = 0.obs;
  late PageController pageController;

  StudentMainState() {
    pageController = PageController(initialPage: 0);
  }
}