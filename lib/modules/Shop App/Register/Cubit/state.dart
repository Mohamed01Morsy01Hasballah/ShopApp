import 'package:saad/models/LoginModel.dart';

abstract class RegisterStates {}
class initialRegisterState extends RegisterStates{}
class RegisterChangeState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final LoginModel loginModel;
  RegisterSuccessState(this.loginModel);

}
class RegisterErrorState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}