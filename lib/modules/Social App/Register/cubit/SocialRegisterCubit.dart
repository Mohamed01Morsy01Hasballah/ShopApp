import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/modules/Social%20App/Register/cubit/SocialRegisterState.dart';

import '../../../../models/SocialModel/SocialUserModel.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit():super(InitialRegisterState());
  static SocialRegisterCubit get(context)=>BlocProvider.of(context);
  var password=true;
  void changePassword(){
    password = !password;
    emit(changeRegisterState());
  }
  void UserRegister({
  required String name,
  required String email,
  required String password,
  required String phone
}){
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print('hello');
      print(value.user!.email);
      print(value.user!.uid);
      UserCreate(
          name: name,
          email: email,
          UID: value.user!.uid,
          phone: phone,

      );
    }).catchError((error){
      emit(RegisterErrorState());
      print("error${error.toString()}");
    });

  }
  void UserCreate(
  {
    required String name,
    required String email,
    required String UID,
    required String phone

}
      ){
    UserModel model=UserModel(
      email: email,
      phone: phone,
      name: name,
      UID: UID,
      isEmailVerified: false
    );
     FirebaseFirestore.instance.collection("users").doc(UID)
         .set(
       model.toMap()

     ).then((value)  {
       emit(CreateUserSucessState());
     }).catchError((error){
       emit(CreateUserErrorState());
       print("error${error.toString()}");

     });

  }

}
