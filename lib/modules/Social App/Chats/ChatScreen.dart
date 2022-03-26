import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/SocialLayout/cubit/cubit.dart';
import 'package:saad/layout/SocialLayout/cubit/state.dart';
import 'package:saad/models/SocialModel/SocialUserModel.dart';
import 'package:saad/modules/Social%20App/Messanger/MessangerScreen.dart';
import 'package:saad/shared/component/components.dart';

class ChatScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=SocialAppCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.users.length > 0,
              builder: (context)=> ListView.separated(
                  itemBuilder: (context,index)=>BuildRowItem(cubit.users[index],context),
                  separatorBuilder:(context,index) =>Container(
                    width:double.infinity,
                    height: 1,
                  ),
                  itemCount: cubit.users.length
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator())
          );
        },

      );


  }
  Widget BuildRowItem(UserModel model,context){
   return InkWell(
     onTap: (){
       navigatepush(context, MessangerScreen(model: model,));
     },
     child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children:
          [
            CircleAvatar(
              radius: 25,
              backgroundImage:
              NetworkImage(
                '${model.image}',
              ),

            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '${model.name}',
              style: TextStyle(
                  fontSize: 16
              ),
            )
          ],
        ),
      ),
   );
  }

}