import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/SocialLayout/SocialLayout.dart';
import 'package:saad/modules/Social%20App/Register/cubit/SocialRegisterCubit.dart';
import 'package:saad/modules/Social%20App/Register/cubit/SocialRegisterState.dart';
import 'package:saad/shared/component/components.dart';

class SocialRegister extends StatelessWidget{
  var email=TextEditingController();
  var password=TextEditingController();
  var name=TextEditingController();
  var phone=TextEditingController();
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialRegisterCubit(),

      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state){
           if(state is CreateUserSucessState){
             NavigateRemove(context, SocialApp());
           }
        },
        builder: (context,state){
          var cubit=SocialRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body:Center(
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
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DefaultTextField(
                            type: TextInputType.name,
                            controller: name,
                            label: 'Name',
                            prefix: Icons.person,
                            function: (value){
                              if(value.isEmpty){
                                return "please Enter Name ";
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
                            label: 'Email',
                            prefix: Icons.email,
                            function: (value){
                              if(value.isEmpty){
                                return "please Enter Email ";
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
                            label: 'password',
                            prefix: Icons.lock_outlined,
                            secure:cubit.password,
                            suffix:cubit.password ?Icons.visibility_off:Icons.visibility ,
                            SuffixPressed: (){
                              cubit.changePassword();
                            },
                            function: (value){
                              if(value.isEmpty){
                                return "please Enter Password ";
                              }
                              return null;

                            }

                        ),

                        SizedBox(
                          height: 20,
                        ),

                        DefaultTextField (
                            type: TextInputType.phone,
                            controller: phone,
                            label: 'Phone',
                            prefix: Icons.phone,
                            function: (value){
                              if(value.isEmpty){
                                return "please Enter Phone ";
                              }
                              return null;

                            }
                        ),
                        SizedBox(
                          height: 20,
                        ),

                       ConditionalBuilder(
                           condition: state is! RegisterLoadingState,
                           builder: (context)=> DefaultButton(
                               width: double.infinity,
                               height: 40,
                               Label: 'Register',
                               function: (){
                                 cubit.UserRegister(
                                     name: name.text,
                                     email: email.text,
                                     password: password.text,
                                     phone: phone.text
                                 );
                               }
                           ),
                           fallback: (context)=>Center(child: CircularProgressIndicator())
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