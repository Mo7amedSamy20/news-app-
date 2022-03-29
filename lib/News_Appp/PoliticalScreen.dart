import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Component.dart';
import 'package:news_app/News_Appp/NewsCubit.dart';
import 'package:news_app/News_Appp/NewsState.dart';

class PoliticalScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).business;
        return ConditionalBuilder(
          condition:list.length > 0  ,
          builder:(context)=> ListView.separated(
            itemBuilder: (context,index)=>buildArticleItem(list[index],context),
            separatorBuilder:(context,index)=>myDivider() ,
            itemCount: list.length,
          ),
          fallback:(context)=>Center(child:(CircularProgressIndicator())) ,
        );
      },
    );
  }

}