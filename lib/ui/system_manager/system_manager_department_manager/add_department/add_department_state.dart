import 'package:flutter/material.dart';

class AddDepartmentState {
  late TextEditingController nameTextController;
  late TextEditingController locationTextController;
  late TextEditingController descriptionTextController;

  AddDepartmentState() {
    nameTextController = TextEditingController(text: '');
    locationTextController = TextEditingController(text: '');
    descriptionTextController = TextEditingController(text: '');
  }
}
