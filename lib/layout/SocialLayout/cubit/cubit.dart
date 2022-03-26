import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saad/layout/SocialLayout/cubit/state.dart';
import 'package:saad/models/SocialModel/CommentModel.dart';
import 'package:saad/models/SocialModel/MessangerModel.dart';
import 'package:saad/models/SocialModel/PostModel.dart';
import 'package:saad/models/SocialModel/SocialUserModel.dart';
import 'package:saad/modules/Social%20App/Chats/ChatScreen.dart';
import 'package:saad/modules/Social%20App/Home/HomeScreen.dart';
import 'package:saad/modules/Social%20App/Post/PostScreen.dart';
import 'package:saad/modules/Social%20App/setting/SettingScreen.dart';
import 'package:saad/modules/Social%20App/users/UserScreen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../shared/component/constant.dart';

class SocialAppCubit extends Cubit<SocialAppStates>{
  SocialAppCubit():super(InitialState());
  static SocialAppCubit get(context)=>BlocProvider.of(context);
  var currentIndex=0;
  List<Widget> Screen=[
    HomeScreen(),
    ChatScreen(),
    PostScreen(),
    UserScreen(),
    SettingScreen(),
  ];
  List<String> titles=[
    'Home',
    'Chat',
    'Post',
    'User',
    'Setting'
  ];
  void changeBottomNav(int index){
    if(index==1){
      GetAllUsers();
    }
    if(index==2){
      emit(SocialPostState());
    }
      else{
      currentIndex=index;
      emit(ChangeBottomNavState());
    }
  }
  UserModel? Usermodel;
  void GetUser(){
    emit( SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection("users").doc(UID).get().then((value)
        {
          Usermodel=UserModel.fromJson(value.data()!);
          emit(SocialGetUserSucessState());
        }
    ).catchError((error){
      print("error${error.toString()}");
      emit(SocialGetUserErrorState());
    });
  }
  File? Profileimage;
  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);


      if (pickedFile != null) {
        Profileimage = File(pickedFile.path);
        emit(SocialProfileImageSucessState());
      } else {
        print('No image selected.');
        emit(SocialProfileImageErrorState());
      }

  }

  File? CoverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      CoverImage = File(pickedFile.path);
      emit(SocialCoverImageSucessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImageErrorState());
    }

  }

  void UploadProfileImage({
    required String name,
    required String bio,
    required String phone,
}){
    emit(SocialUpdateProfileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users / ${Uri.file(Profileimage!.path).pathSegments.last}')
        .putFile(Profileimage!)
        .then((value) {
          value.ref.getDownloadURL().then((value) {
            print(value);
            updateUser(
                name: name,
                bio: bio,
                phone: phone,
              profile: value
            );

          }).catchError((error){
            print('error${error.toString()}');

            emit(SocialUploadProfileImageErrorState());
          });

    }).catchError((error){
      print('error${error.toString()}');
      emit(SocialUploadProfileImageErrorState());

    });
  }
  void UploadCoverImage(
  {
    required String name,
    required String bio,
    required String phone,
}
      ){
    emit(SocialUpdateProfileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(CoverImage!.path).pathSegments.last}')
        .putFile(CoverImage!)
        .then((value){
          value.ref.getDownloadURL().then((value) {
            print(value);
            updateUser(
                name: name,
                bio: bio,
                phone: phone,
                Cover: value
            );
          }).catchError((error){
            emit(SocialUploadCoverImageErrorState());
          });

    }).catchError((error){
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser(
      {
        required String name,
        required String bio,
        required String phone,
        String? Cover,
        String? profile

      }
      ){
    //final FirebaseAuth auth=FirebaseAuth.instance;
   // final User user=auth.currentUser!;
    //final uid=user.uid;
    UserModel model=UserModel(
    name:name,
    bio: bio,
    phone: phone,
    email: Usermodel!.email,
    cover: Cover ?? Usermodel!.cover,
    image:profile ?? Usermodel!.image,
    UID: Usermodel!.UID,
    isEmailVerified: false
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(Usermodel!.UID)
        .update(model.toMap())
        .then((value) {
    GetUser();
    } )
        .catchError((error){
          print('error${error.toString()}');
    emit(SocialUpdateProfileErrorState());

    });
    }

  File? PostImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      PostImage = File(pickedFile.path);
      emit(SocialPostImageSucessState());
    } else {
      print('No image selected.');
      emit(SocialPostImageErrorState());
    }

  }
  void UploadPost({
  required String text,
    required String DateTime,

  }){
    emit(SocialUploadPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts ${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((value) {
          value.ref.getDownloadURL().then((value){
            print(value);
            GetPost(
                text: text,
                DateTime: DateTime,
              postimage: value
            );

          }).catchError((error){
            emit(SocialUploadPostErrorState());

          });

    }).catchError((error){
      emit(SocialUploadPostErrorState());

    });
  }
void GetPost({
  required String text,
  required String DateTime,
  String? postimage

}){
  final FirebaseAuth auth=FirebaseAuth.instance;
  final User user=auth.currentUser!;
  final uid=user.uid;
    PostModel model=PostModel(
      name: Usermodel!.name,
      UID: Usermodel!.UID,
      image: Usermodel!.image,
      text: text,
      DateTime: DateTime,
      PostImage: postimage??''
    );
    FirebaseFirestore.instance
    .collection('posts')
    .add(model.toMap())
    .then((value) {
      emit(SocialUploadPostSucessState());
    }).catchError((error){
      emit(SocialUploadPostErrorState());

    });
}
void RemovePostImage(){
  PostImage=null;
  emit(SocialRemovePostImageState());
}
  List<PostModel> posts=[];
  List<String> postsId=[];
  List<int> likes=[];
  List<int> comments=[];

  void GetPosts(){
  emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
   emit(SocialGetPostsSucessState());
   value.docs.forEach((element) {
     element.reference
     .collection('Likes')
     .get()
     .then((value) {
       likes.add(value.docs.length);
       postsId.add(element.id);
       posts.add(PostModel.fromJson(element.data()));
     }).catchError((error){
            print(error);
     });

   });
   value.docs.forEach((element) {
     element.reference
         .collection('Comments')
         .get().then((value) {
       comments.add(value.docs.length);
     //  postsId.add(element.id);
      // posts.add(PostModel.fromJson(element.data()));
     }).catchError((error){});
   });

    }).catchError((error){
      print(error.toString());
      emit(SocialGetPostsErrorState());
    });
}
void LikePost(String PostId){
 emit(SocialLikePostLoadingState());
  FirebaseFirestore.instance
      .collection('posts')
      .doc(PostId)
      .collection('Likes')
      .doc(Usermodel!.UID)
      .set(
        {
          'like':true
        }
       ).then((value){
     emit(SocialLikePostSucessState());
       })
      .catchError((error){
      emit(SocialLikePostErrorState());
      });
}
void WriteComment(
  {
  required String PostId,
    required String DateTime,
    required String text,
}
    ){
   CommentModel Cmodel =CommentModel(
       name:Usermodel!.name,
       UID:Usermodel!.UID,
       ImageProfile:Usermodel!.image,
       DateTime:DateTime,
       text:text
   );
   FirebaseFirestore.instance
   .collection('posts')
   .doc(PostId)
   .collection('comments')
   .add(Cmodel.toMap())
   .then((value) {
     emit(SocialWriteCommentSucessState());
   }).catchError((error){
     emit(SocialWriteCommentErrorState());
   });

}
List<CommentModel> comment=[];
void GetComment(
  {
  required String PostID
}
    ){
  FirebaseFirestore.instance
      .collection('posts')
      .doc(PostID)
      .collection('comments')
      .orderBy('DateTime')
      .snapshots()
      .listen((event) {
        comment=[];
        event.docs.forEach((element) {
          comment.add(CommentModel.fromjson(element.data()));
        });
        emit(SocialGetCommentSucessState());
  });

}

List<UserModel> users=[];
void GetAllUsers(){
  emit(SocialGetAllUsersLoadingState());
  if(users.length==0)
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
          emit(SocialGetUserSucessState());
          value.docs.forEach((element) {
            if(element.data()['UID'] != Usermodel!.UID)
            users.add(UserModel.fromJson(element.data()));
          });
    })
        .catchError((error){
      emit(SocialGetUserErrorState());

    });

}
void SendMessage(
  {
  required String RecieverID,
    required String DateTime,
    required String text,

  }
    ){
  MessangerModel Model=MessangerModel(
    SenderID: Usermodel!.UID,
    RecieverID: RecieverID,
    DateTime: DateTime,
    Text: text
  );
  FirebaseFirestore.instance
  .collection('users')
  .doc(Usermodel!.UID)
  .collection('chats')
  .doc(RecieverID)
  .collection('Message')
  .add(Model.toMap())
  .then((value) {
    emit(SocialMessangerSucessState());
  })
  .catchError((error){
    emit(SocialMessangerErrorState());

  });

  FirebaseFirestore.instance
      .collection('users')
      .doc(RecieverID)
      .collection('chats')
      .doc(Usermodel!.UID)
      .collection('Message')
      .add(Model.toMap())
      .then((value) {
    emit(SocialMessangerSucessState());
  })
      .catchError((error){
    emit(SocialMessangerErrorState());

  });


}
List<MessangerModel> Message=[];
void GetMessanger({
  required String RecieverID
}){
  FirebaseFirestore.instance
      .collection('users')
      .doc(Usermodel!.UID)
      .collection('chats')
      .doc(RecieverID)
      .collection('Message')
      .orderBy('DateTime')
      .snapshots()
      .listen((event) {
        Message=[];
        event.docs.forEach((element) {
          Message.add(MessangerModel.fromjson(element.data()));
        });
        emit(SocialGetMessangerSucessState());
  });
}
}