import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saad/shared/network/color/style.dart';

import '../../layout/ShopLayout/cubit/cubit.dart';
import '../../models/ProductFavoriteModel.dart';
Widget DefaultAppBar({
   required  BuildContext context,
    String? Title,
   List<Widget>? actions,
})=>AppBar(
   leading:IconButton(
       onPressed: (){
           Navigator.pop(context);
       },
       icon:Icon(
           Icons.arrow_back_ios
       ),
   ),
    title:Text(
        Title!,
    ),
    actions:actions
);
Widget buildBroductItem( model,context){
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
            height: 120,
            child: Row(
                children: [
                    Stack(
                        alignment: Alignment.bottomLeft,
                        children: [

                            Image(
                                image: NetworkImage(model.image.toString()),
                                height: 120,
                                width: 120,
                                fit:BoxFit.cover
                            ),
                            if(model.discount!=0)
                                Container(
                                    color:Colors.red,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                            'DISCOUNT',
                                            style: TextStyle(
                                                color:Colors.white
                                            ),
                                        ),
                                    ),
                                )
                        ]
                    ),
                    SizedBox(
                        width:10,
                    ),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    model.name.toString(),
                                    maxLines: 2,
                                    overflow:TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight:FontWeight.w600
                                    ),
                                ),
                                Spacer(),
                                Row(
                                    children: [
                                        Text(
                                            model.price.toString(),
                                            style: TextStyle(
                                                color:defaultColor
                                            ),
                                        ),
                                        SizedBox(
                                            width:20,
                                        ),
                                        if(model.discount!=0)
                                            Text(
                                                model.oldPrice.toString(),

                                                style: TextStyle(
                                                    color:Colors.grey,
                                                    decoration: TextDecoration.lineThrough
                                                ),
                                            ),
                                        Spacer(),
                                        IconButton(
                                            onPressed: ()
                                            {
                                                ShopCubit.get(context).ChangeFavoriteData(model.id!.toInt());
                                            },
                                            icon: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: ShopCubit.get(context).Favorite![model.id]!?defaultColor:Colors.grey,
                                                child: Icon(

                                                    Icons.favorite_border,
                                                    size: 12,
                                                    color: Colors.white,                              ),
                                            ),
                                        ),

                                    ],
                                )
                            ],
                        ),
                    ),

                ]
            ),
        ),
    );
}
Widget DefaultTextField(
{
    required TextInputType? type,
    required TextEditingController? controller,
    required String label,
    required IconData prefix,
    IconData? suffix,
    required  function,
    bool secure = false,
    SuffixPressed,
   Function? onSubmit,
}
    )=>TextFormField(
    keyboardType: type,
    obscureText: secure,
    controller:controller ,
    validator:function,
    onFieldSubmitted:(s) {
        onSubmit!(s);
    },

    decoration:InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
            prefix
        ),
        suffixIcon: TextButton(
            onPressed: SuffixPressed,
          child: Icon(
              suffix
          ),
        )

    ) ,
);
Widget DefaultButton(
{
    required double width,
    required double height,

    required String Label,
    required Function function,

}
    )=>  Container(
    width: width,
    height: height,
    color: Colors.blue,
    child: MaterialButton(
        onPressed: (){
            function();
        },
        child:
        Text(
            Label.toUpperCase(),
        ),
    ),
);

Widget DefaultTextButton({
    required String label,
    required Function function,
})=>TextButton(
    onPressed: (){
        function();
    },

    child:Text(
          label.toUpperCase(),
      ),

);

void navigatepush(
    context,
    Widget
    )=>Navigator.push(context,
    MaterialPageRoute(
        builder: (context)=>Widget
    )
);
void NavigateRemove(
    context,
    Widget
    )=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context)=>Widget
    ),
    (route) => false
);
void showToast({
    required String Message,
    required ToastState state,
})=>

    Fluttertoast.showToast(
        msg:Message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );

enum ToastState{Sucess,Error,Warning}
Color chooseColor(ToastState state){
    Color color;
    switch(state){
        case ToastState.Sucess:
            color =Colors.green;
            break;
        case ToastState.Error:
            color =Colors.red;
            break;
        case ToastState.Warning:
            color = Colors.yellowAccent;
            break;
    }
    return color;

}
