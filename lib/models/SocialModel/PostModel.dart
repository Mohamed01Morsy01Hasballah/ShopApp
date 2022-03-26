class PostModel{
  String? name;
  String? UID;
  String? image;
  String? text;
  String? DateTime;
  String? PostImage;
  PostModel({
    this.name,
    this.UID,
    this.image,
    this.text,
    this.DateTime,
    this.PostImage
  });
  PostModel.fromJson(Map<String,dynamic> json){
    name =json['name'];
    UID=json['UID'];
    image=json['image'];
    text=json['text'];
    DateTime=json['DateTime'];
    PostImage=json['PostImage'];
  }
  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'image':image,
      'UID':UID,
      'text':text,
      'DateTime':DateTime,
      'PostImage':PostImage
    };
  }
}