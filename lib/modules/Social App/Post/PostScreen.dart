import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/SocialLayout/cubit/cubit.dart';
import 'package:saad/layout/SocialLayout/cubit/state.dart';
import 'package:saad/shared/component/components.dart';

class PostScreen extends StatelessWidget{
  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context,state){},
        builder: (context,state){
        var cubit=SocialAppCubit.get(context);
        var model=SocialAppCubit.get(context).Usermodel;
        return Scaffold(
            appBar:AppBar(
              leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon:Icon(Icons.arrow_back_ios)
              ),
              title:Text(
                  'Profile'
              ),
              actions: [
                DefaultTextButton(
                    label: 'Post',
                    function: (){
                      var now=DateTime.now();
                         if(cubit.PostImage==null){
                           cubit.GetPost(text: textController.text, DateTime: now.toString());
                         }else{
                           cubit.UploadPost(text: textController.text, DateTime: now.toString());
                         }
                    }
                ),
              ],
            ),
            body:Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if(state is SocialUploadPostLoadingState)
                  LinearProgressIndicator(),
                  if(state is SocialUploadPostLoadingState)
                   SizedBox(
                     height: 20,
                   ),
                    Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('${model!.image}'),

                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                          '${model.name}'
                      )

                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller:textController ,
                      decoration: InputDecoration(
                          hintText: 'What\'s Your Mind.....',
                          border:InputBorder.none
                      ),
                    ),
                  ),

                  SizedBox(
                    height:20,
                  ),
                  if(cubit.PostImage !=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image:
                              FileImage(cubit.PostImage!),
                            fit:BoxFit.fill,

                          )
                        ),
                      ),
                      CircleAvatar(
                        radius: 20,
                        child: IconButton(
                            onPressed: (){
                            cubit.RemovePostImage();
                            },
                            icon: Icon(
                              Icons.close,
                            ),
                          color: Colors.white,
                        ),
                      )

                      ]
                  ),
                  SizedBox(
                    height:20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: (){
                              cubit.getPostImage();
                            },
                            child: Row(
                              children: [
                                Icon(
                                    Icons.image
                                ),
                                SizedBox(
                                    width:10
                                ),
                                Text(
                                    'Add Photo'
                                )
                              ],
                            )
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: (){},
                            child:Text(
                                '# Tags'
                            )
                        ),
                      ),


                    ],
                  )
                ],
              ),
            )
        );
    },

    );
  }


}