import 'package:flutter/material.dart';

class TeacherProfileState{
  late TextEditingController phoneTextController;
  late TextEditingController locationTextController;

  TeacherProfileState(){
    phoneTextController = TextEditingController(text: '');
    locationTextController = TextEditingController(text: '');
  }
}