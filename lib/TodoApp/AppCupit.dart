import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/CacheHelper.dart';
import 'package:news_app/TodoApp/AppState.dart';
import 'package:news_app/TodoApp/ArchivedTasks.dart';
import 'package:news_app/TodoApp/DoneTasks.dart';
import 'package:news_app/TodoApp/NewTask.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class AppCupit extends Cubit<AppState>{
    AppCupit():super(IntialAppState());
    static AppCupit get(Context)=>BlocProvider.of(Context);
    Database database;

    int currentindex=0;
    List<Map>NewTasks=[];
    List<Map>ArchivedTasks=[];
    List<Map>DoneTasks=[];

    List<Widget>Screen=[
        NewTask(),
        ArchivedTask(),
        doneTask(),
    ];
    List <String> titles=[
        'New Tasks',
        'Archive Tasks',
        'Done Tasks'
    ];

    bool isDark=false;
    void ChangeMode({bool fromshared})
    {
        if(fromshared!=null) {
            fromshared = isDark;
            emit(ChangeMadeState());
        }
        else {
            isDark = !isDark;
            CacheHelper.putBoolean(key: 'isDark', value: isDark).then((
                value) {
                emit(ChangeMadeState());
            });
        }
    }

    void ChangeBottomNavBar(int index)
    {
        currentindex=index;
        emit(changeBottomNavBar());
    }
    bool isBottomSheetShow=false;
    IconData fabIcon= Icons.edit;

    void bottomsheetshow({
        @required bool isshow,
        @required IconData icon,
    })
    {
        isshow=isBottomSheetShow;
        icon=fabIcon;
        emit(IsBottomSheetShow());
    }
    void CreateDB(){

        openDatabase(
            'NotePade',
            version :1,
            onCreate: (datebase,version){
                print('Datebase Created');
                datebase.execute(  'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
                    .then((value) {
                    print('table created');
                }).catchError((error) {
                    print('Error When Creating Table ${error.toString()}');
                });
            },
            onOpen: (database)
            {
                getdatafromDatabase(database);
                print('database opened');
            },
        ).then((value) {
            database=value;
            emit(AppCreateDataBase());
        });
    }
    Future<void> InsertDateBase({
        @required String title,
        @required String time,
        @required String date,
    }) async {
        await database.transaction((txn) {
            txn.rawInsert('INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
            )
                .then((value) {
                print('$value inserted successfully');
                emit(AppInsertDatabaseState());

                getdatafromDatabase(database);
            }).catchError((error) {
                print('Error When Inserting New Record ${error.toString()}');
            });

            return null;
        });
    }
    void getdatafromDatabase(database)
    {
        NewTasks=[];
        ArchivedTasks=[];
        DoneTasks=[];
        emit(AppGetDatabaseloadingState());
        database.rawQuery('SELECT * FROM tasks').then((value){
            value.forEach((element)
            {
                if(element['status'] == 'new')
                    NewTasks.add(element);
                else if(element['status'] == 'done')
                    DoneTasks.add(element);
                else ArchivedTasks.add(element);

            });
            emit(AppGetDataBase());
        });
    }
    void updateData({
        @required String status,
        @required int id,
    }) async
    {

        database.rawUpdate(
            'UPDATE tasks SET status = ? WHERE id = ?',
            ['$status', id],
        ).then((value)
        {
            getdatafromDatabase(database);
            emit(AppUpdateDatabaseState());
        });
    }

    void deleteData({
        @required int id,
    }) async
    {
        database.rawDelete('DELETE FROM tasks WHERE id = ?', [id])
            .then((value)
        {
            getdatafromDatabase(database);
            emit(AppDeleteDatabaseState());
        });
    }
}
