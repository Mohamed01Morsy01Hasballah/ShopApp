
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/SocialLayout/cubit/cubit.dart';
import 'package:saad/layout/SocialLayout/cubit/state.dart';
import 'package:saad/shared/component/components.dart';

class EditingProfileScreen extends StatelessWidget{
  var name=TextEditingController();
  var bio=TextEditingController();
  var phone=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var model=SocialAppCubit.get(context).Usermodel;
        var ProfileImage=SocialAppCubit.get(context).Profileimage;
        var CoverImage=SocialAppCubit.get(context).CoverImage;

        name.text=model!.name !=null ?model.name!:'';
        bio.text=model.bio !=null ? model.bio! :'';
        phone.text=model.phone !=null ? model.phone!:'';


        return Scaffold(
          appBar:AppBar(
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon:Icon(Icons.arrow_back_ios)
            ),
            title:Text(
                'Profile'
            ),
            actions: [
              DefaultTextButton(label: 'update', function: (){
                SocialAppCubit.get(context).updateUser(
                    name: name.text,
                    bio: bio.text,
                    phone: phone.text
                );
              }),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),

              child: Column(
                children: [
                  if(state is SocialUpdateProfileLoadingState )
                    SizedBox(height: 10,),

                  if(state is SocialUpdateProfileLoadingState )
                    LinearProgressIndicator(),

                  Container(
                    height:  180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 140,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CoverImage == null ?NetworkImage('${model.cover}') :FileImage(CoverImage) as ImageProvider,
                                      fit: BoxFit.fill,

                                    )
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                    onPressed: (){
                                      SocialAppCubit.get(context).getCoverImage();
                                    },
                                    icon: Icon(
                                      Icons.camera_alt_outlined
                                    )
                                ),
                              )
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 61,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage:ProfileImage  == null ? NetworkImage('${model.image}') :FileImage(ProfileImage) as ImageProvider,

                              ),
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: (){
                                    SocialAppCubit.get(context).getProfileImage();
                                  },
                                  icon: Icon(
                                      Icons.camera_alt_outlined
                                  )
                              ),
                            )


                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  if(SocialAppCubit.get(context).Profileimage !=null || SocialAppCubit.get(context).CoverImage !=null)
                    Row(
                    children: [
                      if(SocialAppCubit.get(context).Profileimage !=null)
                      Expanded(
                        child: Column(
                          children: [
                            DefaultTextButton(
                                label: 'Update Profile', 
                                function: (){
                                  SocialAppCubit.get(context).UploadProfileImage(
                                      name: name.text,
                                      bio: bio.text,
                                      phone: phone.text
                                  );
                                }
                            ),
                            if(state is SocialUpdateProfileLoadingState)

                              SizedBox(
                                height:5
                            ),

                            if(state is SocialUpdateProfileLoadingState)
                            LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      if(SocialAppCubit.get(context).CoverImage !=null)
                        Expanded(
                        child: Column(
                          children: [
                            DefaultTextButton(
                                label: 'Update Cover',
                                function: (){
                                  SocialAppCubit.get(context).UploadCoverImage(
                                      name: name.text, 
                                      bio: bio.text, 
                                      phone: phone.text
                                  );
                                }
                            ),
                            if(state is SocialUpdateProfileLoadingState)
                              SizedBox(
                                height:5
                            ),
                            if(state is SocialUpdateProfileLoadingState)
                            LinearProgressIndicator(),
                          ],
                        ),
                      ),

                    ],
                  ),
                  if(SocialAppCubit.get(context).Profileimage !=null || SocialAppCubit.get(context).CoverImage !=null)
                    SizedBox(
                    height: 20,
                  ),
                  DefaultTextField(
                      type: TextInputType.text,
                      controller: name,
                      label: 'Name',
                      prefix: Icons.person,
                      function: (value){
                        if(value.isEmpty){
                          return "Please Enter Name";
                        }
                        return null;
                      }
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DefaultTextField(
                      type: TextInputType.text,
                      controller: bio,
                      label: 'bio',
                      prefix: Icons.info_outlined,
                      function: (value){
                        if(value.isEmpty){
                          return "Please Enter Information";
                        }
                        return null;
                      }
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DefaultTextField(
                      type: TextInputType.phone,
                      controller: phone,
                      label: 'phone',
                      prefix: Icons.phone,
                      function: (value){
                        if(value.isEmpty){
                          return "Please Enter Phone";
                        }
                        return null;
                      }
                  ),


                ],
              ),
            ),
          ),
        );
      },
    );
  }

}