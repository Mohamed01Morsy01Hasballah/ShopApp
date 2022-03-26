import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/SocialLayout/cubit/cubit.dart';
import 'package:saad/layout/SocialLayout/cubit/state.dart';
import 'package:saad/models/SocialModel/CommentModel.dart';
import 'package:saad/shared/network/color/style.dart';

class CommentsScreen extends StatelessWidget{
  var text=TextEditingController();
  final String PostId;
  CommentsScreen({
    Key? key,required this.PostId
}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Builder(

      builder: (BuildContext context) {
        SocialAppCubit.get(context).GetComment(PostID: PostId);
        return BlocConsumer<SocialAppCubit,SocialAppStates>(
          listener: (context,state){},
          builder: (context,state) {
            var cubit=SocialAppCubit.get(context);
           return Scaffold(

                appBar: AppBar(
                  title: Text('Comments'),
                ),
                body:Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context,index)=>BuildRowItem(cubit.comment[index],context),
                          separatorBuilder: (context,index)=>SizedBox(height: 10,),
                          itemCount: cubit.comment.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:Colors.grey[300]!,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [

                            Expanded(
                              child: TextFormField(
                                controller:text,
                                decoration: InputDecoration(
                                  hintText: 'Enter Comment..',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: (){
                                  cubit.WriteComment(
                                      PostId: PostId,
                                      DateTime: DateTime.now().toString(),
                                      text: text.text
                                  );

                                },
                                child: Icon(
                                  Icons.send,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                )
            );
          },

        );
      },

    );

  }
  Widget BuildRowItem(CommentModel model,context)=>Row(
    children: [
      CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage('${model.ImageProfile}'),
      ),
      SizedBox(
        width: 15,
      ),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey[300]!
            ),
            borderRadius:BorderRadius.circular(15),

          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${model.name}',
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  '${model.text}'
              )
            ],
          ),
        ),
      )
    ],
  );


}