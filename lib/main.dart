import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/layout/ShopLayout/ShopLayout.dart';
import 'package:saad/modules/Shop%20App/Login/ShopLoginScreen.dart';
import 'package:saad/shared/component/constant.dart';
import 'package:saad/shared/network/color/style.dart';
import 'package:saad/shared/network/local/CacheHelper.dart';
import 'package:saad/shared/network/remote/DioHelper.dart';
import 'layout/ShopLayout/cubit/cubit.dart';
import 'layout/ShopLayout/cubit/states.dart';
import 'modules/Shop App/onBoarding/OnBoard.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.getinit();
  await CacheHelper.getinit();
    Widget widget;
   bool? onBoarding =CacheHelper.getData(key: "onBoarding");
   print(onBoarding);

  String? token=CacheHelper.getData(key: 'token');
  print(token);
  if(onBoarding !=null){
    if(token !=null) widget=ShopLayout();
    else widget=ShopLogin();
  }else{
    widget=OnBoard();
  }



  runApp(MyApp(widget));
}
class MyApp extends StatelessWidget{
 Widget? widget;
 MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopCubit()..GetHomeData()..GetCategoryData()..GetProductFav()..GetProfileData(),

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

