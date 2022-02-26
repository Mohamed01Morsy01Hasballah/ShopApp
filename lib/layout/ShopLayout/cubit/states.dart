import 'package:saad/models/ChangeFavorite.dart';

abstract class ShopStates{}
class initialState extends ShopStates{}
class changeBottomNavState extends ShopStates{}
class HomeDataLoadingState extends ShopStates{}
class HomeDataSuccessState extends ShopStates{}
class HomeDataErrorState extends ShopStates{}
class ProductFavDataSuccessState extends ShopStates{}
class ProductFavDataErrorState extends ShopStates{}

class CategoryDataLoadingState extends ShopStates{}
class CategoryDataSuccessState extends ShopStates{}
class CategoryDataErrorState extends ShopStates{}
class FavoriteDataSuccessState extends ShopStates{
  ChangeFavorite? changeFavorite;
  FavoriteDataSuccessState(this.changeFavorite);
}
class FavoriteDataErrorState extends ShopStates{}

class FavoriteDataLoadingState extends ShopStates{}

class changeFavouriteState extends ShopStates{}
class ShopLoadingProfileDataState extends ShopStates{}
class ShopSuccessProfileDataState extends ShopStates{}
class ShopErrorProfileDataState extends ShopStates{}

class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates{}
class ShopErrorUpdateUserState extends ShopStates{}