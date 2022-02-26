import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/modules/Shop%20App/search/cubit/state.dart';
import 'package:saad/shared/component/components.dart';

import 'cubit/cubit.dart';

class SearchScreen extends StatelessWidget{
  var text=TextEditingController();
  var fromKey=GlobalKey<FormState>();
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return BlocProvider(
      create: (BuildContext context)  =>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=SearchCubit.get(context);
          return Scaffold(
              appBar: AppBar(),
              body:Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: fromKey,
                  child: Column(
                    children: [
                      DefaultTextField(
                        type: TextInputType.text,
                        controller: text,
                        label: 'Search',
                        prefix: Icons.search,
                        function: (value){
                          if(value.isEmpty){
                            return"please Enter Text";
                          }
                          return null;
                        },
                        onSubmit: (String text){
                          cubit.SearchData(text:text);
                        }

                      ),
                    const  SizedBox(
                        height: 20,
                      ),
                      if(state is SearchLoadingState)
                        LinearProgressIndicator(),
                   const   SizedBox(
                        height: 20,
                      ),
                      if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context,index)=>buildBroductItem(cubit.searchModel!.data!.data![index],context),
                          separatorBuilder: (context,index)=>Container(
                              height:1,
                              width: double.infinity,
                              color:Colors.grey
                          ),
                          itemCount: cubit.searchModel!.data!.data!.length,
                        ),
                      ),


                    ],
                  ),
                ),
              ),

          );
        }
      ),
    );
  }

}