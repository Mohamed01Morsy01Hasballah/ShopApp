import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/models/LoginModel.dart';
import 'package:saad/modules/Shop%20App/Register/Cubit/state.dart';
import 'package:saad/shared/network/remote/DioHelper.dart';

import '../../../../shared/network/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit():super(initialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  bool password=true;
  void changeIconRegister(){
    password = !password;
    emit(RegisterChangeState());
  }
  LoginModel? loginModel;
  void getRegister(
  {
  required String name,
    required String email,
    required String password,
    required String phone,
  }
      ){
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone
        }
    ).then((value) {
      loginModel=LoginModel.formJson(value.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error){
      emit(RegisterErrorState());
    });
  }

}