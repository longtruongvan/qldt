import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateInfomationState {
  RxBool statusLoading = false.obs;
  late TextEditingController phoneTextController;
  late TextEditingController locationTextController;

  UpdateInfomationState(){
    phoneTextController = TextEditingController(text: '');
    locationTextController = TextEditingController(text: '');
  }
}
