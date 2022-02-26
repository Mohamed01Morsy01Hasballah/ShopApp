import 'dart:math';

class CategoryModel{
  bool? status;
  CategoryDataModel? data;
  CategoryModel.fromJson(Map<String ,dynamic>json){
    status=json['status'];
    data=CategoryDataModel.fromJson(json['data']);
  }
}
class CategoryDataModel{
  int? current_page;
  List<dynamic> data=[];
  CategoryDataModel.fromJson(Map<String ,dynamic>json){
    current_page=json['current_page'];
    json['data'].forEach((elements){
      data.add(dataModel.fromJson(elements));
    });
  }
}
class dataModel{
  int? id;
  String? name;
  String? image;
  dataModel.fromJson(Map<String ,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}