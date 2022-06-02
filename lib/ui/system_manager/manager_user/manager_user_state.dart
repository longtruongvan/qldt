import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/response/person_response.dart';

class ManagerUserState {
  RxList<PersonResponse> currentListPersonResponse = <PersonResponse>[].obs;
  RxList<PersonResponse> listPersonResponse = <PersonResponse>[].obs;
  RxBool statusLoading = false.obs;
  late TextEditingController searchTextController;

  ManagerUserState() {
    searchTextController = TextEditingController(text: '');
  }
}
