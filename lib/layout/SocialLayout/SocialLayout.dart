import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/SocialLayout/cubit/cubit.dart';
import 'package:saad/layout/SocialLayout/cubit/state.dart';
import 'package:saad/modules/Social%20App/Post/PostScreen.dart';
import 'package:saad/shared/component/components.dart';

class SocialApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context,state){
        if(state is SocialPostState){
          navigatepush(context,PostScreen());
        }
      },
      builder: (context,state){
        var cubit=SocialAppCubit.get(context);


        return  Scaffold(
          appBar: AppBar(
            title:Text( cubit.titles[cubit.currentIndex]),
          ),
           body:cubit.Screen[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home
                  ),
                label:'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.chat
                  ),
                  label:'Chat'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.cloud_upload_outlined
                  ),
                  label:'Post'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.person
                  ),
                  label:'User'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.settings
                  ),
                  label:'Setting'
              ),

            ],
          ) ,

        );
    },


    );
  }

}