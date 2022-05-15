import 'package:qldt/model/response/department_response.dart';
import 'package:qldt/ui/system_manager/system_manager_department_manager/system_manager_department_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SystemManagerDepartmentLogic{
  final state = SystemManagerDepartmentState();

  SystemManagerDepartmentLogic(){
    fetchData();
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
}