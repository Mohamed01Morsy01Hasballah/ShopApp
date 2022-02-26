import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saad/models/SearchModel.dart';
import 'package:saad/modules/Shop%20App/search/cubit/state.dart';
import 'package:saad/shared/network/local/CacheHelper.dart';
import 'package:saad/shared/network/remote/DioHelper.dart';

import '../../../../shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel? searchModel;
  void SearchData({required text}){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token:  CacheHelper.getData(key: "token"),
        data: {
          "text":text
        }
    ).then((value){
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
      print(error.toString());
    });

  }
}