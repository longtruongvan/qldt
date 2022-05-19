import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:qldt/model/response/person_response.dart';

class AuthService extends GetxService {
  Rxn<PersonResponse> person = Rxn<PersonResponse>();
  Rxn<User> user = Rxn<User>();

  Future<AuthService> init() async {
    return this;
  }

  void updatePerson(PersonResponse personResponse) {
    person.value = personResponse;
  }

  void updateUser(User user){
    this.user.value = user;
  }

  void deleteUser() {
    person.value = null;
    user.value = null;
  }

  void signOut(){
    deleteUser();
  }
}
