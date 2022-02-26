import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/ShopLayout/cubit/cubit.dart';
import 'package:saad/layout/ShopLayout/cubit/states.dart';
import 'package:saad/models/CategoryModel.dart';

class CategoriesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context,index)=>buildCategoryItem(cubit.categoryModel!.data!.data[index]),
            separatorBuilder: (context,index)=>Container(
              height: 1,
              width: double.infinity,
              color:Colors.grey[300],
            ),
            itemCount: cubit.categoryModel!.data!.data.length
        );

      },
    );
  }
Widget buildCategoryItem(dataModel? model)=>Padding(
  padding: const EdgeInsets.all(10),
  child:   Row(
    children: [

      Image(

          image: NetworkImage('${model!.image}'),

          height: 120,

          width: 120,

          fit:BoxFit.cover

      ),

      SizedBox(

        width:10,

      ),

      Text(

          '${model.name}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600
        ),

      ),

      Spacer(),

      IconButton(

        onPressed: (){},

        icon: Icon(Icons.arrow_forward_ios),

      ),

    ],

  ),
);
}