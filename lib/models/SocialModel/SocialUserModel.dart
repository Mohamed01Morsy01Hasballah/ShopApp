class UserModel{
  String? name;
  String? email;
  String? phone;
  String? UID;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;
  UserModel({
    this.name,
    this.email,
    this.phone,
    this.UID,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified
});
  UserModel.fromJson(Map<String,dynamic> json){
    name =json['name'];
    email =json['email'];
    phone=json['phone'];
    UID=json['UID'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    isEmailVerified=json['isEmailVerified'];
  }
  Map<String,dynamic> toMap(){
 return{
   'name':name,
   'email':email,
   'phone':phone,
   'bio':bio,
   'image':image,
   'cover':cover,
   'UID':UID,
   'isEmailVerified':isEmailVerified,
 };
  }
}