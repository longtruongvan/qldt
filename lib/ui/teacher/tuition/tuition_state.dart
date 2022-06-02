import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/response/class_response.dart';
import '../../../model/response/person_response.dart';
import '../../../model/response/specialized_response.dart';

class TuitionState {

  RxList<PersonResponse> currentListPersonResponse = <PersonResponse>[].obs;
  RxList<PersonResponse> listPersonResponse = <PersonResponse>[].obs;
  Rx<PersonResponse> personResponseSelected = PersonResponse().obs;

  RxList<ClassResponse> currentListClassResponse = <ClassResponse>[].obs;
  RxList<ClassResponse> listClassResponse = <ClassResponse>[].obs;
  Rx<ClassResponse> classResponseSelected = ClassResponse().obs;
  late TextEditingController searchTextController;

  TuitionState() {
    searchTextController = TextEditingController();
  }
}
