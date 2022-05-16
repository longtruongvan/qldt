import 'package:qldt/model/response/department_response.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/system_manager_department_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/response/building_response.dart';

class SystemManagerDepartmentLogic{
  final state = SystemManagerDepartmentState();

  SystemManagerDepartmentLogic(){
    fetchData();
    getDataListBuilding();
  }

  void fetchData() async{
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var collectionStream =  FirebaseFirestore.instance.collection('Department').get().then((value){
      if(value!=null){
        value.docs.forEach((doc) {
          print(doc.id);
        });
      }
    });
    Stream documentStream =  FirebaseFirestore.instance.collection('Department').doc('123456789').snapshots();

    if(collectionStream!=null){

    }

    if(documentStream!=null){

    }


    FirebaseFirestore.instance.collection('Department').snapshots().listen((dataSnapshot) {
      if(dataSnapshot.docs.isNotEmpty){
        var data = dataSnapshot.docs.map((snapshot){
          var x=DepartmentResponse.fromJson(snapshot.data());
          print("");
        }).toList();
      }
    });
  }

  void getDataListBuilding() {
    state.stateLoading.value = true;
    FirebaseFirestore.instance
        .collection('Building')
        .snapshots()
        .listen((dataSnapshot) {
      if (dataSnapshot.docs.isNotEmpty) {
        state.listBuilding.clear();
        var data = dataSnapshot.docs.map((snapshot) {
          var response = BuildingResponse.fromJson(snapshot.data());
          state.listBuilding.add(response);
        }).toList();
        state.stateLoading.value = false;
      } else {
        state.stateLoading.value = false;
      }
    });
  }
}