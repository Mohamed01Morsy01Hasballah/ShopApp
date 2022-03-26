import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/SocialLayout/cubit/cubit.dart';
import 'package:saad/layout/SocialLayout/cubit/state.dart';
import 'package:saad/modules/Social%20App/EditProfile/EditProfileScreen.dart';
import 'package:saad/shared/component/components.dart';

class SettingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit,SocialAppStates>(
      listener: (context,state){},
      builder: (context,state){
        var model=SocialAppCubit.get(context).Usermodel;
       return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 180,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height:140,
                        width:double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage('${model!.cover}'),

                                fit: BoxFit.fill
                            )

                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 61,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60,
                           backgroundImage: NetworkImage('${model.image}'),
                    ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${model.name.toString()}',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${model.bio}',
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color:Colors.grey
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  color:Colors.grey
                              ),
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  color:Colors.grey
                              ),
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  color:Colors.grey
                              ),
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                  color:Colors.grey
                              ),
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),




                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: (){},
                        child: Text(
                            'Add Photos'
                        )

                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: (){
                        navigatepush(context,EditingProfileScreen());
                      },
                      child: Icon(
                          Icons.edit
                      )
                  )
                ],
              )
            ],
          ),
        );
      },

    );
  }

}