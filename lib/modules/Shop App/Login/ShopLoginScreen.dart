import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saad/modules/Shop%20App/Login/Cubit/cubit.dart';
import 'package:saad/modules/Shop%20App/Login/Cubit/states.dart';
import 'package:saad/modules/Shop%20App/Register/ShopRegisterScreen.dart';
import 'package:saad/shared/component/components.dart';
import 'package:saad/shared/network/local/CacheHelper.dart';

import '../../../layout/ShopLayout/ShopLayout.dart';
import '../../../shared/component/constant.dart';

class  ShopLogin extends StatelessWidget{
  var email=TextEditingController();
  var password=TextEditingController();
  var formkey=GlobalKey<FormState>();
  ShopLogin({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
 return BlocProvider(
   create: (context)=>ShopLoginCubit(),

   child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
     listener:(context,state){
       if(state is ShopLoginSuccessState){
         if(state.loginmodel.status!) {
           print(state.loginmodel.message);
           print(state.loginmodel.data!.token);
           CacheHelper.saveData(
               key: "token",
               value: state.loginmodel.data!.token).
           then((value) {
             token=state.loginmodel.data!.token!;
             NavigateRemove(context,  ShopLayout());
           });



         }
         else {
           print(state.loginmodel.message);
           showToast(Message: state.loginmodel.message!, state: ToastState.Error);
         }
       }
     } ,
     builder:(context,state){

       return Scaffold(
         appBar: AppBar(),
         body:
         Center(
           child: SingleChildScrollView(
             child: Padding(
               padding: const EdgeInsets.all(20),
               child: Form(
                 key: formkey,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'Login',
                       style: Theme.of(context).textTheme.headline5?.copyWith(
                           color:Colors.black
                       ),
                     ),
                     SizedBox(
                       height: 10,
                     ),
                     Text(
                       'Login Shop App found a lot of food ',
                       style: Theme.of(context).textTheme.bodyText1?.copyWith(
                           color:Colors.grey
                       ),
                     ),
                     SizedBox(
                       height: 20,
                     ),
                     DefaultTextField(
                         type: TextInputType.emailAddress,
                         controller: email,
                         label: 'Email Address',
                         prefix: Icons.email,
                         function: (value){
                           if(value.isEmpty){
                             return 'Email not can Empty';
                           }else
                             return null;
                         }
                     ),
                     SizedBox(
                       height: 20,
                     ),
                     DefaultTextField(
                       type: TextInputType.visiblePassword,
                       controller: password,
                       label: 'Password',
                       prefix: Icons.lock_outlined,
                       function: (value){
                         if(value.isEmpty){
                           return 'password not can Empty';
                         }else
                           return null;
                       },
                       suffix:ShopLoginCubit.get(context).secure? Icons.visibility_off_outlined:Icons.visibility,
                       secure: ShopLoginCubit.get(context).secure,
                       SuffixPressed: (){
                         ShopLoginCubit.get(context).changeIcon();
                       }

                     ),
                     SizedBox(
                         height:20
                     ),
                    ConditionalBuilder(
                        condition: state is! ShopLoginLoadingState,
                        builder: (context)=> DefaultButton(
                            width: double.infinity,
                            height: 40,
                            Label: 'sign in',
                            function: (){
                              if(formkey.currentState!.validate()){
                                ShopLoginCubit.get(context).getLogin(
                                    email: email.text,
                                    password: password.text
                                );
                              }

                            }
                        ),
                        fallback: (context)=>Center(child: CircularProgressIndicator())
                    ),
                     SizedBox(
                         height:20
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children:
                       [
                         Text(
                           'Don\'t Have Register  ',
                         ),
                         SizedBox(
                           width: 30,
                         ),
                         DefaultTextButton(
                             label: 'sign up',
                             function: (){
                               navigatepush(context, RegisterScreen());
                             }
                         )
                       ],
                     ),



                   ],
                 ),
               ),
             ),
           ),
         ),

       );
     } ,
   ),
 );
  }

}