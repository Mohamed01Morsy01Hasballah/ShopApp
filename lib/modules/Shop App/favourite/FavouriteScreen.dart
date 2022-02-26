import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/ShopLayout/cubit/cubit.dart';
import 'package:saad/layout/ShopLayout/cubit/states.dart';
import 'package:saad/models/ProductFavoriteModel.dart';
import 'package:saad/shared/network/color/style.dart';

import '../../../shared/component/components.dart';

class FavouriteScreen extends StatelessWidget{

  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){
          if( state is FavoriteDataSuccessState){
            if(state.changeFavorite!.status!){
              showToast(Message: state.changeFavorite!.Message!, state: ToastState.Error);
            }
          }
        },
      builder: (context,state){
          var cubit=ShopCubit.get(context);
          return ConditionalBuilder(
              condition: state is! FavoriteDataLoadingState,
              builder: (context)=>ListView.separated(
                itemBuilder: (context,index)=>buildBroductItem(cubit.productmodel!.data!.data![index].product,context),
                separatorBuilder: (context,index)=>Container(
                    height:1,
                    width: double.infinity,
                    color:Colors.grey
                ),
                itemCount: cubit.productmodel!.data!.data!.length,
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator()),
          );
      },

    );






}

}