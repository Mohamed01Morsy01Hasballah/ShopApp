import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/ShopLayout/ShopLayout.dart';
import 'package:saad/layout/SocialLayout/SocialLayout.dart';
import 'package:saad/layout/SocialLayout/cubit/cubit.dart';
import 'package:saad/modules/Shop%20App/Login/ShopLoginScreen.dart';
import 'package:saad/modules/Social%20App/Login/SocialLogin.dart';
import 'package:saad/modules/Social%20App/Login/cubit/SocialCubit.dart';
import 'package:saad/shared/component/constant.dart';
import 'package:saad/shared/network/color/style.dart';
import 'package:saad/shared/network/local/CacheHelper.dart';
import 'package:saad/shared/network/remote/DioHelper.dart';
import 'layout/ShopLayout/cubit/cubit.dart';
import 'layout/ShopLayout/cubit/states.dart';
import 'modules/Shop App/onBoarding/OnBoard.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  DioHelper.getinit();
  await CacheHelper.getinit();
    Widget widget;
  // bool? onBoarding =CacheHelper.getData(key: "onBoarding");
 //  print(onBoarding);

 // String? token=CacheHelper.getData(key: 'token');
 // print(token);
  //if(onBoarding !=null){
  //  if(token !=null) widget=ShopLayout();
  //  else widget=ShopLogin();
 // }else{
 //   widget=OnBoard();
//  }

   UID=CacheHelper.getData(key: "UID");
  if(UID !=null){
    widget=SocialApp();
  }else{
    widget=SocialLogin();
  }

  runApp(MyApp(widget));
}
class MyApp extends StatelessWidget{
 Widget? widget;
 MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context)=>ShopCubit()..GetHomeData()..GetCategoryData()..GetProductFav()..GetProfileData(),

        ),
        BlocProvider(
          create: (BuildContext context)=>SocialAppCubit()..GetUser()..GetPosts(),

        ),


      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: defaultColor,
                appBarTheme: AppBarTheme(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                    ),

                    iconTheme:IconThemeData(
                      color: Colors.black
                    ) ,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.black,
                        statusBarBrightness: Brightness.light
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.black54,
                    selectedItemColor: defaultColor,
                    unselectedItemColor: Colors.grey
                )
            ),
            home:widget,
          );
        },

      ),
    );
  }


}

