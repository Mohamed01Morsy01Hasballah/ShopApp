class MessangerModel{
  String? SenderID;
  String? RecieverID;
  String? DateTime;
  String? Text;


  MessangerModel({
    this.SenderID,
    this.RecieverID,
    this.DateTime,
    this.Text,
});
  MessangerModel.fromjson(Map<String,dynamic>json){

    SenderID=json['SenderId'];
    RecieverID=json['RecieverID'];
    DateTime=json['DateTime'];
    Text=json['Text'];

  }
  Map<String ,dynamic > toMap(){
    return {
      'SenderID':SenderID,
      'RecieverID':RecieverID,
      'DateTime':DateTime,
      'Text':Text
    };

  }
}