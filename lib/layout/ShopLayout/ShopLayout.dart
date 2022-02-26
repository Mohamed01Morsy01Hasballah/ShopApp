import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/ShopLayout/cubit/cubit.dart';
import 'package:saad/layout/ShopLayout/cubit/states.dart';
import 'package:saad/modules/Shop%20App/search/SearchScreen.dart';
import 'package:saad/shared/component/components.dart';

class ShopLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Salla'
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigatepush(context, SearchScreen());
                   },
                  icon:Icon( Icons.search)
              ),
            ],

          ),
          body:cubit.Screens[cubit.currentIndex] ,
          bottomNavigationBar: BottomNavigationBar(

            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.ChangeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                  ),
                  label: 'categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'Favorite'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Setting'
              ),


            ],
          ),
        );
      },
    );
  }

}