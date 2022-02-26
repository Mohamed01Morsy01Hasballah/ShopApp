import 'package:saad/models/LoginModel.dart';

abstract class ShopLoginStates {}

class ShopLoginIntialState extends ShopLoginStates{}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}
class ShopLoginSuccessState extends ShopLoginStates{

  final LoginModel loginmodel ;
 ShopLoginSuccessState(this.loginmodel);
}
class ShopLoginLoadingState extends ShopLoginStates{}
class ChangeIconState extends ShopLoginStates{}



