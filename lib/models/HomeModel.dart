import 'dart:math';

class HomeModel{
  bool? status;
  HomeDataModel? data;
    HomeModel.fromJson(Map<String,dynamic>json){
      status=json['status'];
      data=HomeDataModel.fromJson(json['data']);
    }


}
class HomeDataModel{
    List<dynamic> banners=[];
    List<dynamic> products=[];

  HomeDataModel.fromJson(Map<String,dynamic> json){
    json['banners'].forEach((elements){
      banners.add(bannersModel.fromJson(elements));
    });
    json['products'].forEach((elements){
      products.add(productsModel.fromJson(elements));
    });
    }

}
class bannersModel{

    int ?id;
    String? image;
  bannersModel.fromJson(Map<String,dynamic> json){
   id=json['id'];
   image=json['image'];

  }
}
class productsModel{
   int? id;
   dynamic price;
  dynamic old_price;
   dynamic discount;
    String? image;
   String? name;
   bool? in_favorites;
   bool? in_cart;
  productsModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];
  }
}