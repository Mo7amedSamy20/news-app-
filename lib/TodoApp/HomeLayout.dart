
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Component.dart';
import 'package:news_app/TodoApp/AppCupit.dart';
import 'package:news_app/TodoApp/AppState.dart';

class HomeLayout extends StatelessWidget{
  var scaffoldkey=GlobalKey<ScaffoldState>();
  var formkey =GlobalKey<FormState>();
  var titleController;
  var timeController;
  var dateController;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>AppCupit(),
       child: BlocConsumer<AppCupit,AppState>(
             listener: (BuildContext context,AppState State){
               if(State is AppInsertDatabaseState)
               {
                 Navigator.pop(context);
               }
             },
             builder:(BuildContext context,AppState State)
                {
                  AppCupit cubit=AppCupit.get(context);
                      return Scaffold(
                          appBar: AppBar(
                          title: Text(cubit.titles[cubit.currentindex]),
                          ),
                          body:ConditionalBuilder(
                            condition: State is! AppGetDatabaseloadingState,
                            builder: (context)=>cubit.Screen[cubit.currentindex],
                            fallback: (context)=>Center(child: CircularProgressIndicator(),),
                          ),
                          floatingActionButton: FloatingActionButton(
                            onPressed: () {
                              if (cubit.isBottomSheetShow) {

                                if (formkey.currentState.validate()) {
                                  cubit.InsertDateBase(
                                    title: titleController.text,
                                    time: timeController.text,
                                    date: dateController.text,
                                  );
                                }
                              }
                              else {
                               scaffoldkey.currentState.showBottomSheet(
                                       ( context) => Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Form(
                                          key: formkey,
                                          child: Column(
                                            children: [
                                              defaultFormField(
                                                  controller: titleController,
                                                  type: TextInputType.text,
                                                  validate: (String value) {
                                                    if (value.isEmpty)
                                                      return 'title must not be empty';
                                                  },
                                                  label: 'Task',
                                                  prefix: Icons.mail_outline
                                              ),
                                              SizedBox(height: 10.0,),
                                              defaultFormField(
                                                  controller: timeController,
                                                  type: TextInputType.datetime,
                                                  onTap: () {
                                                    showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay.now())
                                                        .then((value) {
                                                      timeController.text =
                                                          value.format(context)
                                                              .toString();
                                                      print(value.format(context));
                                                    });
                                                  },
                                                  validate: (String value) {
                                                    if (value.isEmpty)
                                                      return 'time must not be empity';
                                                  },
                                                  label: 'time',
                                                  prefix: Icons.watch_later_outlined
                                              ),
                                              SizedBox(height: 10.0,),
                                              defaultFormField(
                                                controller: dateController,
                                                type: TextInputType.datetime,
                                                onTap: () {
                                                  showDatePicker(context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.parse(
                                                        '30-9-2025'),
                                                  );
                                                },
                                                validate: (String value) {
                                                  if (value.isEmpty)
                                                    return 'date must not be empty';
                                                },
                                                label: 'Date',
                                                prefix: Icons.calendar_today_outlined,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                               ).closed
                                   .then((value) {
                                 cubit.bottomsheetshow(isshow: false, icon: Icons.edit);
                               });
                               cubit.bottomsheetshow(isshow: true, icon: Icons.add);
                              }
                            },
                            child: Icon(cubit.fabIcon),
                          ),
                           bottomNavigationBar: BottomNavigationBar(
                              type: BottomNavigationBarType.fixed,
                              currentIndex: cubit.currentindex,
                             onTap: (index)
                             {
                               cubit.ChangeBottomNavBar(index);
                             },
                             items: [
                               BottomNavigationBarItem(icon:Icon(Icons.menu),label: 'Tasks'),
                               BottomNavigationBarItem(icon:Icon(Icons.archive),label: 'Archive'),
                               BottomNavigationBarItem(icon:Icon(Icons.done),label: 'Done'),
                             ],
                           ),
                      );
                }
                ),
    );
  }

}