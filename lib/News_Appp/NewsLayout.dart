import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Component.dart';
import 'package:news_app/News_Appp/NewsCubit.dart';
import 'package:news_app/News_Appp/NewsState.dart';
import 'package:news_app/News_Appp/SearchScreen.dart';
import 'package:news_app/TodoApp/AppCupit.dart';

class Newslayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(
                  icon: Icon(Icons.brightness_4),
                  onPressed: () {
                    AppCupit.get(context).ChangeMode();
                  },
                ),
                SizedBox(width: 15.0,),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, SearchScreen(),);
                  },
                ),
              ],
            ),
            body: cubit.screen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar
              (
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeBotNavBar(index);
              },
              items: cubit.items,
            )
            ,
          );
        }
    );
  }
}