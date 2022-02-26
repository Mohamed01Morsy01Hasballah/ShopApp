import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/ShopLayout/cubit/states.dart';
import 'package:saad/models/CategoryModel.dart';
import 'package:saad/models/ChangeFavorite.dart';
import 'package:saad/models/HomeModel.dart';
import 'package:saad/models/LoginModel.dart';
import 'package:saad/models/ProductFavoriteModel.dart';
import 'package:saad/modules/Shop%20App/categories/CategoriesScreen.dart';
import 'package:saad/modules/Shop%20App/favourite/FavouriteScreen.dart';
import 'package:saad/modules/Shop%20App/products/ProductScreen.dart';
import 'package:saad/modules/Shop%20App/setting/SettingScreen.dart';
import 'package:saad/shared/component/constant.dart';
import 'package:saad/shared/network/end_points.dart';
import 'package:saad/shared/network/local/CacheHelper.dart';
import 'package:saad/shared/network/remote/DioHelper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(initialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  void ChangeBottomNav(index){
    currentIndex=index;
    emit(changeBottomNavState());
  }
  List<Widget> Screens=[
    ProductScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingScreen()
  ];
  HomeModel? homeModel;
  CategoryModel? categoryModel;
  Map<int,bool >? Favorite={};

  void GetHomeData(){
    emit(HomeDataLoadingState());
    DioHelper.getData(
        url: HOME,
      token:CacheHelper.getData(key: "token"),
    ).then((value) {
      homeModel=HomeModel.fromJson(value.data);
      //print(homeModel!.status);
     // print(homeModel!.data!.banners[0].image);
     // print(homeModel!.data!.banners[0].id);
      homeModel!.data!.products.forEach((element) {
        Favorite!.addAll(({
          element.id:
          element.in_favorites
        }));

      });
      print(Favorite.toString());

      emit(HomeDataSuccessState());
    }).catchError((error){
      print("error${error.toString()}");
      emit(HomeDataErrorState());
    });
  }
  FavoritesModel? productmodel;
  void GetProductFav(){
    emit( FavoriteDataLoadingState());
    DioHelper.getData(
        url: FAVORITE,
      token:CacheHelper.getData(key: "token"),
    ).then((value) {
      productmodel=FavoritesModel.fromJson(value.data);
      emit(ProductFavDataSuccessState());
    }).catchError((error){
      emit(ProductFavDataErrorState());
    });
  }
  ChangeFavorite? changeFavorite;
  void ChangeFavoriteData(int productId){
    Favorite![productId] = !Favorite![productId]!;
    emit(changeFavouriteState());
    DioHelper.postData(
        url: FAVORITE,
        token:CacheHelper.getData(key: "token"),
        data: {
          'product_id':productId,

        },
    ).then((value)  {
      changeFavorite=ChangeFavorite.fromJson(value.data);
      print(value.data);
      if(changeFavorite!.status !=true)
      {
        Favorite![productId] = !Favorite![productId]!;

      }else{
        GetProductFav();
      }
      emit(FavoriteDataSuccessState(changeFavorite));
    }).catchError((error){
      Favorite![productId] = !Favorite![productId]!;

      emit(FavoriteDataErrorState());

    });

  }
  void GetCategoryData(){
    DioHelper.getData(
        url: CATEGORY
    ).then((value)  {
      categoryModel=CategoryModel.fromJson(value.data);
      emit(CategoryDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CategoryDataErrorState());
    });
  }
  LoginModel? loginModel;
  void GetProfileData(){
    emit(ShopLoadingProfileDataState());
    DioHelper.getData(
        url: PROFILE,
      token:CacheHelper.getData(key: "token"),
    ).then((value) {
      loginModel=LoginModel.formJson(value.data);
      emit(ShopSuccessProfileDataState());
    }).catchError((error){
      emit(ShopErrorProfileDataState());
    });
  }
  void UpdateUserProfile({
  required String? name,
    required String? email,
    required String? phone

}){
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
        url: UPDATE,
        token: CacheHelper.getData(key: "token"),
        data: {
          'name':name,
          'email':email,
          'phone':phone
        }
    ).then((value) {
      loginModel=LoginModel.formJson(value.data);
      emit(ShopSuccessUpdateUserState());
    }).catchError((error){
      emit(ShopErrorUpdateUserState());
      print(error.toString());
    });

  }
}