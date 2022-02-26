import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/ShopLayout/cubit/cubit.dart';
import 'package:saad/layout/ShopLayout/cubit/states.dart';
import 'package:saad/shared/component/components.dart';
import 'package:saad/shared/component/constant.dart';

class   SettingScreen extends StatelessWidget{
  var name=TextEditingController();
  var email=TextEditingController();
  var phone=TextEditingController();
  var formkey=GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {


    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        name.text=cubit.loginModel!.data!.name.toString();
        email.text=cubit.loginModel!.data!.email.toString();
        phone.text=cubit.loginModel!.data!.phone.toString();

        return  ConditionalBuilder(
            condition: cubit.loginModel !=null,
            builder: (context)=> Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key:formkey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserState)
                    const  LinearProgressIndicator(),
                   const SizedBox(
                      height: 20,
                    ),
                    DefaultTextField(
                        type: TextInputType.name,
                        controller: name,
                        label: 'Name',
                        prefix: Icons.person,
                        function: (value){
                          if(value.isEmpty){
                            return "Must not empty";
                          }
                          return null;
                        }
                    ),
                  const  SizedBox(
                      height: 20,
                    ),
                    DefaultTextField(
                        type: TextInputType.emailAddress,
                        controller: email,
                        label: 'Email',
                        prefix: Icons.email,
                        function: (value){
                          if(value.isEmpty){
                            return "Must not empty";
                          }
                          return null;
                        }
                    ),
                 const   SizedBox(
                      height: 20,
                    ),
                    DefaultTextField(
                        type: TextInputType.phone,
                        controller: phone,
                        label: 'Phone',
                        prefix: Icons.phone,
                        function: (value){
                          if(value.isEmpty){
                            return "Must not empty";
                          }
                          return null;
                        }
                    ),
                  const  SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                        width: double.infinity,
                        height: 40,
                        Label: 'update',
                        function: (){
                          if(formkey.currentState!.validate()) {
                            ShopCubit.get(context).UpdateUserProfile(name: name.text, email: email.text, phone: phone.text);
                          }
                        }
                    ),
                  const SizedBox(
                      height: 20,
                    ),

                    DefaultButton(
                        width: double.infinity,
                        height: 40,
                        Label: 'logout',
                        function: (){
                          Signout(context);
                        }
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context)=>const Center(child: CircularProgressIndicator())
        );

      },
    );
  }

}