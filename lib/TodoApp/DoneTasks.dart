import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Component.dart';
import 'package:news_app/TodoApp/AppCupit.dart';
import 'package:news_app/TodoApp/AppState.dart';


class doneTask extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCupit, AppState>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var tasks = AppCupit.get(context).DoneTasks;

        return tasksBuilder(
            tasks: tasks
        );
      },
    );
  }

}