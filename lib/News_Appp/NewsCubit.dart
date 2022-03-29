import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/News_Appp/PoliticalScreen.dart';
import 'package:news_app/News_Appp/ScienceScreen.dart';
import 'package:news_app/News_Appp/SportsScreen.dart';
import 'package:news_app/dio%20helper.dart';

import 'NewsState.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super((NewsIntialState()));

  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<BottomNavigationBarItem> items=
  [
    BottomNavigationBarItem(
      icon: Icon(
          Icons.business
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Icons.science_outlined
      ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Icons.sports
      ),
      label: 'Sports',
    )
  ];
  void ChangeBotNavBar(int index)
  {
    currentIndex=index;
    if(index==1)
      getscience();
    if(index==2)
      getsports();
    emit(ChangeAppNavBar());
  }
  List<Widget>screen=
  [
    PoliticalScreen(),
    ScienceScreen(),
    SportsScreen()
  ];
  List<dynamic>business=[];
  void getbusiness()
  {
    emit(GetLoadingBusiness());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query:
        {
          'Country' :'eg',
          'category':'business',
          'apikey':'57a6c36aacc34faea3ae14a17f1fed0a'
        }).then((value)
    {
      business=value.data['articles'];
      print(business[0]['title']);
      emit(GetdataSuccesBusiness());
    }).catchError((error){
      print(error.toString());
      emit(GetdataErroeBusiness(error.toString()));
    });
  }
  List<dynamic>sports=[];
  void getsports()
  {
    emit(GetLoadingSports());
    if(sports.length == 0 )
    {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'Country' :'eg',
            'category':'sports',
            'apikey':'57a6c36aacc34faea3ae14a17f1fed0a'
          }).then((value)
      {
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(GetdataSuccesSports());
      }).catchError((error){
        print(error.toString());
        emit(GetdataErroeSports(error.toString()));
      });
    }else{
      emit(GetdataSuccesSports());
    }


  }
  List<dynamic>science=[];
  void getscience()
  {
    if(science.length==0){
      emit(GetLoadingScienceState());
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'Country' :'eg',
            'category':'science',
            'apikey':'57a6c36aacc34faea3ae14a17f1fed0a'
          }).then((value)
      {
        science=value.data['articles'];
        print(science[0]['title']);
        emit(GetdataSuccesScienceState());
      }).catchError((error){
        print(error.toString());
        emit(GetdataErroeScienceState(error.toString()));
      });
    }else{
      emit(GetdataSuccesScienceState());
    }

  }
  List<dynamic>search=[];
  void getsearch(String value)
  {

    emit(GetLoadingSearchState());
    DioHelper.getData(
        url: 'v2/everything',
        query:
        {
          'q':'$value',
          'apikey':'57a6c36aacc34faea3ae14a17f1fed0a'
        }).then((value)
    {
      search=value.data['articles'];
      print(search[0]['title']);
      emit(GetdataSuccesSearchState());
    }).catchError((error){
      print(error.toString());
      emit(GetdataErroeSearchState(error.toString()));
    });

    emit(GetdataSuccesSearchState());


  }

}