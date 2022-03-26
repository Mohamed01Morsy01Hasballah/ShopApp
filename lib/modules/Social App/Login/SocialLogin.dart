import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/SocialLayout/SocialLayout.dart';
import 'package:saad/modules/Social%20App/Login/cubit/SocialCubit.dart';
import 'package:saad/modules/Social%20App/Login/cubit/SocialStates.dart';
import 'package:saad/modules/Social%20App/Register/SocialRegister.dart';
import 'package:saad/shared/component/components.dart';
import 'package:saad/shared/network/local/CacheHelper.dart';

class SocialLogin extends StatelessWidget{
  var email=TextEditingController();
  var pass=TextEditingController();
  var formkey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   return BlocProvider(
     create: (BuildContext context) =>SocialLoginCubit(),
     child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
       listener: (context,state){

         if(state is LoginSuccessState){
           CacheHelper.saveData(
               key: "UID",
               value: state.UID
           ).then((value) {
          NavigateRemove(context, SocialApp());
           });
         }
          if(state is LoginErrorState){
           showToast(Message: state.error, state: ToastState.Error);
         }
       },
       builder: (context,state){
         var cubit=SocialLoginCubit.get(context);
         return  Scaffold(
           appBar: AppBar(
               title: Text(
                   'Social App'
               )
           ),
           body: Center(
             child: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(20),
                 child: Form(
                   key: formkey,
                   child: Column(
                     crossAxisAlignment:CrossAxisAlignment.start,
                     children: [
                       Text(
                         'Login',
                         style:Theme.of(context).textTheme.headline5,
                       ),
                       SizedBox(
                         height: 10,
                       ),
                       Text(
                         'Sign in Please so that Access Pages Social App',
                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
                             color:Colors.grey
                         ),
                       ),
                       SizedBox(
                         height: 10,
                       ),
                       DefaultTextField(
                           type: TextInputType.emailAddress,
                           controller: email,
                           label: 'Email Address',
                           prefix: Icons.email,
                           function: (value){
                             if(value.isEmpty){
                               return "Please Enter Email ";
                             }
                             return null;
                           }
                       ),
                       SizedBox(
                         height: 20,
                       ),
                       DefaultTextField(
                           type: TextInputType.visiblePassword,
                           controller: pass,
                           label: 'Password',
                           prefix: Icons.lock_outlined,
                           suffix:cubit.password?Icons.visibility_off_outlined:Icons.visibility,
                           secure: cubit.password,
                           SuffixPressed: (){
                             cubit.changePassword();
                           },
                           function: (value){
                             if(value.isEmpty){
                               return "Please Enter Passord ";
                             }
                             return null;
                           }
                       ),
                       SizedBox(
                         height: 20,
                       ),
                     ConditionalBuilder(
                         condition: state is! LoginLoadingState,
                         builder: (context)=>  DefaultButton(
                             width: double.infinity,
                             height: 40,
                             Label: 'sign in',
                             function: (){
                               cubit.UserLogin(
                                   email: email.text,
                                   password: pass.text
                               );
                             }
                         ),
                         fallback: (context)=>Center(child: CircularProgressIndicator()),
                     ),
                       SizedBox(
                         height: 20,
                       ),

                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,

                         children: [
                           Text(
                             'Don\'t Have Account ',
                           ),
                           SizedBox(
                             width: 20,
                           ),
                           DefaultTextButton(
                               label: 'sign up',
                               function: (){
                                 navigatepush(context, SocialRegister());
                               }
                           ),
                         ],
                       )



                     ],
                   ),
                 ),
               ),
             ),
           ),

         );
       },

     ),
   );

  }


}