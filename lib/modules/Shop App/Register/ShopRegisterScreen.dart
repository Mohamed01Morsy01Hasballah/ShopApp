import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/modules/Shop%20App/Register/Cubit/cubit.dart';
import 'package:saad/modules/Shop%20App/Register/Cubit/state.dart';
import 'package:saad/shared/component/components.dart';
import 'package:saad/shared/network/local/CacheHelper.dart';

import '../../../layout/ShopLayout/ShopLayout.dart';
import '../../../shared/component/constant.dart';

class RegisterScreen extends StatelessWidget{
  var name=TextEditingController();
  var email=TextEditingController();
  var password=TextEditingController();
  var phone=TextEditingController();
  var formkey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterSuccessState){
            if(state.loginModel.status!){
              CacheHelper.saveData(
                  key: "token",
                  value: state.loginModel.data!.token
              ).then((value){
                token=state.loginModel.data!.token;
                showToast(Message: state.loginModel.message!, state:ToastState.Sucess );
                NavigateRemove(context,  ShopLayout());

              });
            }
            else{
              showToast(Message: state.loginModel.message!, state:ToastState.Error );

            }

          }
        },
        builder: (context,state){
          var cubit=RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style:Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Register within Form So that GO Home',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        DefaultTextField(
                            type: TextInputType.name,
                            controller: name,
                            label: 'Name',
                            prefix: Icons.person,
                            function: (value){
                              if(value.isEmpty){
                                return "please Enter Name";
                              }
                              return null;
                            }
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
                                return "please Enter Email";
                              }
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
                            secure:cubit.password,
                            suffix: cubit.password ? Icons.visibility_off_outlined:Icons.visibility,
                            SuffixPressed: (){
                              cubit.changeIconRegister();
                            },
                            function: (value){
                              if(value.isEmpty){
                                return "please Enter password";
                              }
                              return null;
                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DefaultTextField(
                            type: TextInputType.phone,
                            controller: phone,
                            label: 'Phone',
                            prefix: Icons.phone,
                            function: (value){
                              if(value.isEmpty){
                                return "please Enter phone";
                              }
                              return null;
                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder:(context)=>DefaultButton(
                              width: double.infinity,
                              height: 40,
                              Label: 'Register',
                              function: (){
                                if(formkey.currentState!.validate()){
                                  cubit.getRegister(
                                      name: name.text,
                                      email: email.text,
                                      password: password.text,
                                      phone: phone.text
                                  );
                                }

                              }
                          ) ,
                          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                        ),



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