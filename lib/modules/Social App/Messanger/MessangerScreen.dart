import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/SocialLayout/cubit/cubit.dart';
import 'package:saad/layout/SocialLayout/cubit/state.dart';
import 'package:saad/models/SocialModel/MessangerModel.dart';
import 'package:saad/models/SocialModel/SocialUserModel.dart';
import 'package:saad/shared/network/color/style.dart';

class MessangerScreen extends StatelessWidget{
  var text=TextEditingController();
  UserModel? model;
  MessangerScreen(
  {
    this.model,
}
      );
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
       SocialAppCubit.get(context).GetMessanger(RecieverID: model!.UID.toString());
        return BlocConsumer<SocialAppCubit,SocialAppStates>(
          listener: (context,state){},
          builder: (context,state){
            var cubit=SocialAppCubit.get(context);
            return Scaffold(
                appBar:AppBar(
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('${model!.image}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                          '${model!.name}'
                      )
                    ],
                  ),
                ),
                body:ConditionalBuilder(
                    condition: cubit.Message.length>=0,
                    builder: (context)=>Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              physics:BouncingScrollPhysics(),
                                itemBuilder: (context,index){
                                  var message=SocialAppCubit.get(context).Message[index];
                                  if(SocialAppCubit.get(context).Usermodel!.UID==message.RecieverID)
                                    return BuiltMyMessage(message);

                                  return BuiltMessage(message);
                                },
                                separatorBuilder: (context,index)=>SizedBox(height:20),
                                itemCount: cubit.Message.length
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:Colors.grey[300]!,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children: [

                                Expanded(
                                  child: TextFormField(
                                    controller:text,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Comment..',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  color: defaultColor,
                                  child: MaterialButton(
                                    onPressed: (){
                                      cubit.SendMessage(
                                          RecieverID: model!.UID.toString(),
                                          DateTime: DateTime.now().toString(),
                                          text: text.text
                                      );
                                    },
                                    child: Icon(
                                      Icons.send,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    fallback:(context)=> Center(child: CircularProgressIndicator())
                ),
            );
          },

        );
      },

    );
  }

 Widget BuiltMessage(MessangerModel model)=> Align(
   alignment:AlignmentDirectional.centerStart ,
   child: Container(
     decoration: BoxDecoration(
       borderRadius:BorderRadiusDirectional.only(
           bottomEnd: Radius.circular(15),
           topStart: Radius.circular(15),
           topEnd: Radius.circular(15)
       ),
       color:Colors.grey[300],

     ),
     padding: EdgeInsets.symmetric(
         vertical: 5.0,
         horizontal:10
     ),
     child: Text('${model.Text}'),
   ),
 );
  Widget BuiltMyMessage(MessangerModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        decoration:BoxDecoration(
          borderRadius:BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(15),
            topStart: Radius.circular(15),
            topEnd: Radius.circular(15),
          ),
          color:defaultColor.withOpacity(0.7),

        ),
        padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10
        ),
        child:Text('${model.Text}')
    ),
  );

}