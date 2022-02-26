import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/models/LoginModel.dart';
import 'package:saad/modules/Shop%20App/Login/Cubit/states.dart';
import 'package:saad/shared/network/remote/DioHelper.dart';

import '../../../../shared/network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit():super(ShopLoginIntialState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  bool secure=true;
    LoginModel? loginModel;
void changeIcon(){
  secure= !secure;
  emit(ChangeIconState());
}
 void getLogin({
   String? email,
    String? password
}){
   emit(ShopLoginLoadingState());
   DioHelper.postData(
       url: LOGIN,
       data: {
         'email':email,
         'password':password
       }
   ).then((value) {

    loginModel= LoginModel.formJson(value.data);


     emit(ShopLoginSuccessState(loginModel!));
   }).catchError((error){
     emit(ShopLoginErrorState(error));
   });
 }
}