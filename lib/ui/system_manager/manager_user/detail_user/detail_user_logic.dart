import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/class_response.dart';
import 'package:qldt/model/response/person_response.dart';
import 'package:qldt/model/response/specialized_response.dart';
import 'package:qldt/ui/system_manager/manager_user/detail_user/detail_user_state.dart';

class DetailUserLogic extends GetxController {
  final state = DetailUserState();

  void getData(PersonResponse personResponse) {
    state.statusLoading.value = true;

    state.mergeRequest.listen((value) {
      if(value<=0){
        state.statusLoading.value = false;
      }
    });

    if (personResponse.idClass != null) {
      state.mergeRequest.value++;
      getClassById(personResponse.idClass!, (status) {
        state.mergeRequest.value--;
      });
    }

    if(personResponse.idSpecialized!=null){
      state.mergeRequest.value++;
      getSpecializedById(personResponse.idSpecialized!, (status) {
        state.mergeRequest.value--;
      });
    }
  }

  void getSpecializedById(String id, Function(bool) callback) {
    FirebaseFirestore.instance.collection('Specialized').doc(id).get().then((value) {
      if (value.data() != null) {
        var response = SpecializedResponse.fromJson(value.data()!);
        state.specializedResponse.value = response;
      }
      callback(true);
    }).catchError((onError) {
      callback(false);
    });
  }

  void getClassById(String id, Function(bool) callback) {
    FirebaseFirestore.instance.collection('Classs').doc(id).get().then((value) {
      if (value.data() != null) {
        var response = ClassResponse.fromJson(value.data()!);
        state.classResponse.value = response;
      }
      callback(true);
    }).catchError((onError) {
      callback(false);
    });
  }
}
