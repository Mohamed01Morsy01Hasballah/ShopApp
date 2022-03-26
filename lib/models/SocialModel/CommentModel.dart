class CommentModel{
  String? name;
  String? UID;
  String? ImageProfile;
  String? DateTime;
  String? text;
  CommentModel({
    this.name,
    this.UID,
    this.DateTime,
    this.text,
    this.ImageProfile
});
  CommentModel.fromjson(Map<String ,dynamic>json){
    name=json['name'];
    UID=json['UID'];
    ImageProfile=json['ImageProfile'];
    DateTime=json['DateTime'];
    text=json['text'];


  }
  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'UID':UID,
      'ImageProfile':ImageProfile,
      'DateTime':DateTime,
      'text':text,

    };
  }


}