import 'package:flutter/material.dart';
import 'package:saad/shared/component/components.dart';
import 'package:saad/shared/network/local/CacheHelper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/network/color/style.dart';
import '../Login/ShopLoginScreen.dart';
class Board{
  String? image;
  String? body;
  String? title;

  Board
      ({
    required  this.image,
    required  this.body,
    required this.title
  });

}
class OnBoard extends StatefulWidget{

  @override
  State<OnBoard> createState() => _OnBoardState();

}

class _OnBoardState extends State<OnBoard> {
  @override
   var BoardController=PageController();
  bool last=false;
  List <Board> boardon=[
    Board(
        image: 'https://images.pexels.com/photos/326268/pexels-photo-326268.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        body: 'Programming Mohamed Morsy ',
        title: 'Board on 1'
    ),
    Board(
        image: 'https://images.pexels.com/photos/326268/pexels-photo-326268.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        body: 'Programming Mohamed Elabd ',
        title: 'Board on 2'
    ),
    Board(
        image: 'https://images.pexels.com/photos/326268/pexels-photo-326268.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
        body: 'Programming Mohamed Zidan ',
        title: 'Board on 3'
    ),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
         appBar:AppBar(
           title:Text(
             'Shop App',
             style: TextStyle(
               fontSize: 30,
               fontWeight: FontWeight.bold
             ),



           ),
           actions: [
             TextButton(
                 onPressed: (){
                   Submit(context);
                 },
                 child: Text(
                   'SKIP'
                 )
             ),
           ],

         ),
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                  controller: BoardController,
                  onPageChanged: (int index){
                  if(index==boardon.length-1){
                    setState(() {
                      last=true;
                    });
                  }else{
                    setState(() {
                      last=false;
                    });
                  }
                  },
                  itemBuilder: (context,index)=>BulidBoardOnItem(boardon[index]),
                itemCount: boardon.length,
              ),
            ),
            Row(
              children: [
               SmoothPageIndicator(
                   controller: BoardController,
                   count: boardon.length,
                 effect: ExpandingDotsEffect(
                   dotWidth: 10,
                   dotHeight: 10,
                   dotColor: Colors.grey,
                   activeDotColor: defaultColor,
                   expansionFactor: 4,
                   spacing: 5.0
                 ),
               ),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(last){
                       Submit(context);
                      }else{
                        BoardController.nextPage(duration: Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);

                      }

                    },
                    child:Icon(
                      Icons.arrow_forward_ios,
                    )
                )
              ],
            )


          ],
        ),
      )

    );
  }
}
Widget BulidBoardOnItem(Board model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    Expanded(
      child: Image(
        image:NetworkImage('${model.image}'),
      ),
    ),
    SizedBox(
      height: 20,
    ),

    Text(
      '${model.body} ',
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
      ),
    ),
    SizedBox(
      height: 20,
    ),
    Text(
      '${model.title}',
    )
  ],
);
void Submit(context){
  CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
    if(value) {
      NavigateRemove(context, ShopLogin());
    }

  });
}

