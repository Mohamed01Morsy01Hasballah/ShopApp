
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/ShopLayout/cubit/cubit.dart';
import 'package:saad/layout/ShopLayout/cubit/states.dart';
import 'package:saad/models/CategoryModel.dart';
import 'package:saad/models/HomeModel.dart';
import 'package:saad/shared/component/components.dart';
import 'package:saad/shared/network/color/style.dart';

class ProductScreen extends StatelessWidget{
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state ){
        if( state is FavoriteDataSuccessState){
          if(state.changeFavorite!.status!){
            showToast(Message: state.changeFavorite!.Message!, state: ToastState.Error);
          }
        }
      },
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel !=null && cubit.categoryModel !=null,

            builder: (context)=>ProductItem(cubit.homeModel,cubit.categoryModel,context),

          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },

    );
  }
  Widget ProductItem( HomeModel? model,CategoryModel? cmodel,context)=>SingleChildScrollView(
    physics:BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         CarouselSlider(
             items: model!.data!.banners.map((e) =>Image(
               image:NetworkImage('${e.image}'),
               width: double.infinity,
               fit: BoxFit.cover,
             ) ).toList(),
             options: CarouselOptions(
               height: 250,
               viewportFraction:1.0,
               initialPage:0,
               reverse: false,
               enableInfiniteScroll: true,
               autoPlay: true,
               autoPlayInterval: Duration(seconds: 3),
               autoPlayAnimationDuration: Duration(seconds: 1),
               autoPlayCurve: Curves.fastOutSlowIn,
               scrollDirection: Axis.horizontal

             )
         ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Container(
                 height: 110,
                 child: ListView.separated(
                   scrollDirection:Axis.horizontal ,
                     itemBuilder: (context,index)=>BuildCategoryItem(cmodel!.data!.data[index]),
                     separatorBuilder: (context,index)=>SizedBox(width:10),
                     itemCount: cmodel!.data!.data.length
                 ),
               ),
              SizedBox(
                height: 30,
              ),

              Text(
                'New Products',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
              crossAxisCount: 2,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.72,
            children:List.generate(model.data!.products.length, (index) =>BuilderProductImage(model.data!.products[index],context)
            ),
              ),
        ),
      ],
    ),
  );
  Widget BuilderProductImage(productsModel? model,context)=>Container(
    color: Colors.white,
    child: Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Stack(
          alignment:Alignment.bottomLeft  ,
          children: [
            Image(
              image: NetworkImage('${model!.image}'),
              width: double.infinity,
              fit:BoxFit.fill,
              height: 200.0,
            ),
            if(model.discount !=0)
            Container(
              color: Colors.red,
             child:Padding(
               padding: const EdgeInsets.all(10),
               child: Text(
                   'DISCOUNT',
                       style: TextStyle(
                         color: Colors.white
                       ),
                       
               ),
             ),
              
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow:TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4

                ),

              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style:TextStyle(
                      color: defaultColor,
                    ),

                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if(model.discount !=0)
                  Text(
                    '${model.old_price.round()}',
                    style:TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),

                  ),
                  Spacer(),
                  IconButton(
                      onPressed: (){
                        ShopCubit.get(context).ChangeFavoriteData(model.id!.toInt());
                            },

                      icon:CircleAvatar(
                        radius:  15,
                        backgroundColor: ShopCubit.get(context).Favorite![model.id]! ? defaultColor:Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 12,
                          color: Colors.white,
                        ),
                      )
                  )

                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
  Widget BuildCategoryItem(dataModel? model)=>Stack(
    alignment: Alignment.bottomCenter,

    children: [
      Image(
        image: NetworkImage('${model!.image}'),
        width:110,
        height: 110,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.7),
        width:110,


        child: Text(
          '${model.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white,

              fontSize: 14,
              fontWeight: FontWeight.w500
          ),
        ),
      )
    ],
  );

}