import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/SocialLayout/cubit/cubit.dart';
import 'package:saad/layout/SocialLayout/cubit/state.dart';
import 'package:saad/models/SocialModel/PostModel.dart';
import 'package:saad/modules/Social%20App/Comments/CommentsScreen.dart';
import 'package:saad/shared/component/components.dart';
import 'package:saad/shared/network/color/style.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=SocialAppCubit.get(context);
        var model=SocialAppCubit.get(context).Usermodel;

        return ConditionalBuilder(
            condition: cubit.posts.length>=0,
            builder: (context)=>SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(

                    clipBehavior:Clip.antiAliasWithSaveLayer,
                    elevation: 10,
                    margin: EdgeInsets.symmetric(
                        horizontal: 8.0
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image:
                              NetworkImage('https://tse3.mm.bing.net/th?id=OIP.Jr8rXCYx9fVAvw2CAD9argHaE8&pid=Api&P=0&w=268&h=178'),
                          fit: BoxFit.fill,
                          height: 200,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Comunicate With Friends',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index)=>BulidPostItem(cubit.posts[index],context,index),
                      separatorBuilder:(context,index)=>SizedBox(height: 8.0,) ,
                      itemCount:cubit.posts.length
                  ),
                  SizedBox(height:10 ,),

                ],
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator())
        );
      },

    );
  }
 Widget BulidPostItem(PostModel model,context,index)=> Card(
   clipBehavior:Clip.antiAliasWithSaveLayer,
   elevation: 10,
   margin: EdgeInsets.symmetric(
       horizontal: 8.0
   ),
   child: Padding(
     padding: const EdgeInsets.all(10),
     child: Column(
       crossAxisAlignment:CrossAxisAlignment.start,

       children: [
         Row(
           children: [
             CircleAvatar(
               radius: 20,
               backgroundImage:
                 NetworkImage('${model.image}')
             ),
             SizedBox(
               width: 5,
             ),

             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [
                       Text(
                         '${model.name}',
                         style: TextStyle(
                             height: 1.3
                         ),
                       ),
                       SizedBox(
                         width: 7,
                       ),
                       Icon(
                         Icons.check_circle,
                         color: defaultColor,
                         size: 15,
                       )
                     ],
                   ),
                   Text(
                     '${model.DateTime}',
                     style: Theme.of(context).textTheme.caption!.copyWith(
                         color: Colors.grey,
                         height: 1.3
                     ),
                   )

                 ],
               ),
             ),
             SizedBox(
               width: 15,
             ),
             IconButton(
                 onPressed: (){},
                 icon: Icon(
                     Icons.more_horiz
                 )
             )
           ],
         ),
         Padding(
           padding: const EdgeInsets.symmetric(
               vertical: 10
           ),
           child: Container(
             width: double.infinity,
             height: 1,
             color: Colors.grey,
           ),
         ),
         Text(
           '${model.text}',
           style:TextStyle(
               fontSize: 14,
               height: 1.3
           ),
         ),
        // Padding(
         //            padding: const EdgeInsets.symmetric(
         //                vertical: 10
         //            ),
         //            child: Container(
         //              width: double.infinity,
         //              child: Wrap(
         //                children: [
         //                  Padding(
         //                    padding: const EdgeInsetsDirectional.only(end:10),
         //                    child: Container(
         //                      height:25,
         //                      child: MaterialButton(
         //                        minWidth: 10,
         //                        height: 20,
         //                        padding: EdgeInsets.zero,
         //                        onPressed: (){},
         //                        child: Text(
         //                          '#Software',
         //                          style: Theme.of(context).textTheme.caption!.copyWith(
         //                              color:defaultColor
         //                          ),
         //
         //                        ),
         //                      ),
         //                    ),
         //                  ),
         //                  Padding(
         //                    padding: const EdgeInsetsDirectional.only(end:2),
         //                    child: Container(
         //                      height:25,
         //                      child: MaterialButton(
         //                        minWidth: 10,
         //                        height: 20,
         //                        padding: EdgeInsets.zero,
         //
         //                        onPressed: (){},
         //                        child: Text(
         //                          '#Flutter',
         //                          style: Theme.of(context).textTheme.caption!.copyWith(
         //                              color:defaultColor
         //                          ),
         //
         //                        ),
         //                      ),
         //                    ),
         //                  ),
         //                  Padding(
         //                    padding: const EdgeInsetsDirectional.only(end:7),
         //                    child: Container(
         //                      height:25,
         //                      child: MaterialButton(
         //                        minWidth: 10,
         //                        height: 20,
         //                        padding: EdgeInsets.zero,
         //
         //                        onPressed: (){},
         //                        child: Text(
         //                          '#Artificial_Inteligence',
         //                          style: Theme.of(context).textTheme.caption!.copyWith(
         //                              color:defaultColor
         //                          ),
         //
         //                        ),
         //                      ),
         //                    ),
         //                  ),
         //
         //                ],
         //              ),
         //            ),
         //          ),
         if(model.PostImage !='')
         Padding(
           padding: const EdgeInsetsDirectional.only(
             top: 15
           ),
           child: Container(
             height: 120,
             decoration:BoxDecoration(
                 image: DecorationImage(
                     image:
                         NetworkImage('${model.PostImage}'),
                     fit: BoxFit.fill
                 )
             ) ,
           ),
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10),
           child: Row(
             children: [
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10),
                   child: InkWell(
                     child: Row(
                       children: [
                         Icon(
                           Icons.check_box_sharp,
                           color: Colors.red,
                         ),
                         SizedBox(
                           width: 5,
                         ),
                         Text(
                           '${SocialAppCubit.get(context).likes[index]}',
                           style: Theme.of(context).textTheme.caption!.copyWith(
                               color:Colors.grey
                           ),
                         ),
                       ],
                     ),
                     onTap: (){},
                   ),
                 ),
               ),
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(
                       vertical: 10
                   ),
                   child: InkWell(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Icon(
                           Icons.chat,
                           color: Colors.amber,
                         ),
                         SizedBox(
                           width: 5,
                         ),
                         Text(
                           '${SocialAppCubit.get(context).comments[index]}',
                           style: Theme.of(context).textTheme.caption!.copyWith(
                               color:Colors.grey
                           ),
                         ),
                       ],
                     ),
                     onTap: (){},
                   ),
                 ),
               ),

             ],
           ),
         ),
         Container(
             width:double.infinity,
             height: 1,
             color:Colors.grey[300]
         ),
         Padding(
           padding: const EdgeInsets.symmetric(
               vertical: 10
           ),
           child: Row(
             children: [
               Expanded(
                 child: InkWell(
                   child: Row(
                     children: [
                       CircleAvatar(
                         radius: 20,
                         backgroundImage:
                           NetworkImage('${SocialAppCubit.get(context).Usermodel!.image}')
                       ),
                       SizedBox(
                         width: 10,
                       ),
                       Text(
                         'write Comment...',
                         style: Theme.of(context).textTheme.caption!.copyWith(
                             color:Colors.grey
                         ),
                       ),
                     ],
                   ),
                   onTap: (){
                     navigatepush(context,CommentsScreen(PostId: SocialAppCubit.get(context).postsId[index],));
                   },
                 ),
               ),
               Expanded(
                 child: InkWell(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       Icon(
                         Icons.check_box_sharp,
                         color: Colors.grey,
                       ),
                       SizedBox(
                         width: 5,
                       ),
                       Text(
                         'Like',
                         style: Theme.of(context).textTheme.caption!.copyWith(
                             color:Colors.grey
                         ),
                       ),
                     ],
                   ),
                   onTap: (){
                     SocialAppCubit.get(context).LikePost(SocialAppCubit.get(context).postsId[index]);
                   },
                 ),
               ),
             ],
           ),
         )

       ],
     ),
   ),
 );
}