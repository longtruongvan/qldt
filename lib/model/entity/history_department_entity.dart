import 'package:qldt/model/response/department_history_response.dart';
import 'package:qldt/model/response/department_response.dart';
import 'package:qldt/model/response/person_response.dart';

class HistoryDepartmentEntity {
  PersonResponse? personResponse;
  DepartmentResponse? departmentResponse;
  DepartmentHistoryResponse? departmentHistoryResponse;

  HistoryDepartmentEntity({
    this.personResponse,
    this.departmentResponse,
    this.departmentHistoryResponse,
  });
}
