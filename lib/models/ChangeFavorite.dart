class ChangeFavorite{
   bool? status;
   String? Message;
   ChangeFavorite.fromJson(Map<String,dynamic>json){
     status=json['status'];
     Message=json['message'];
   }
}