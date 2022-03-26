abstract class SocialLoginStates{}
class InitialState extends SocialLoginStates{}
class ChangeState extends SocialLoginStates{}
class LoginLoadingState extends SocialLoginStates{}
class LoginSuccessState extends SocialLoginStates{
   String? UID;
  LoginSuccessState(this.UID);
}
class LoginErrorState extends SocialLoginStates{
  final String error;
  LoginErrorState(this.error);
}