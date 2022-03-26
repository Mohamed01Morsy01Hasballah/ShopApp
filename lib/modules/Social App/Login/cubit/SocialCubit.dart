import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/modules/Social%20App/Login/cubit/SocialStates.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit():super(InitialState());
  static SocialLoginCubit get(context)=>BlocProvider.of(context);
   bool password = true;
   void changePassword(){
     password = !password;
     emit(ChangeState());
   }
   void UserLogin({
  required String email,
  required String password
}){
     emit(LoginLoadingState());
     FirebaseAuth.instance.signInWithEmailAndPassword(
         email: email,
         password: password
     ).then((value){
       print(value.user!.email);
       print(value.user!.uid);

       emit(LoginSuccessState(value.user!.uid));
     }).catchError((error){
       print("error${error.toString()}");
       emit(LoginErrorState(error.toString()));
     });
   }
}