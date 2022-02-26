import 'package:saad/modules/Shop%20App/Login/ShopLoginScreen.dart';
import 'package:saad/shared/component/components.dart';
import 'package:saad/shared/network/local/CacheHelper.dart';

void prinFullText(String Text){
 final pattern=RegExp('.{1,800}');
pattern.allMatches(Text).forEach((element) {
  print(element.group(0));
});
}
void Signout(context){
  CacheHelper.removeData(key: 'token').then((value)  {

      NavigateRemove(context, ShopLogin());

  });
}
String? token;