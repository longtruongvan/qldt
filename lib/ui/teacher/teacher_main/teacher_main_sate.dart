import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherMainState{
  RxInt itemSelected = 0.obs;
  late PageController pageController;

  TeacherMainState(){
    pageController = PageController();
  }
}