import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/CacheHelper.dart';
import 'package:news_app/MyBlocObserver.dart';
import 'package:news_app/News_Appp/NewsCubit.dart';
import 'package:news_app/News_Appp/NewsLayout.dart';
import 'package:news_app/TodoApp/AppCupit.dart';
import 'package:news_app/TodoApp/AppState.dart';
import 'package:news_app/dio%20helper.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool IsDark=CacheHelper.getBoolean(key: 'isDark');

  DioHelper.init();
  runApp(MyApp(IsDark));
}
class MyApp extends StatelessWidget {

  final bool IsDark;
  MyApp(this.IsDark);

  // constructor
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getbusiness()..getscience()..getsports()),
        BlocProvider(create:(BuildContext context)=>AppCupit()..ChangeMode(
          fromshared: IsDark,
        ))
      ],
      child:BlocConsumer<AppCupit,AppState>(
        listener: (context,state){},
        builder:(context,state) {
          return MaterialApp(
            themeMode: AppCupit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  titleTextStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    unselectedItemColor: Colors.grey,
                    selectedItemColor: Colors.deepOrange,
                    backgroundColor: Colors.white
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.black,
                    )
                )
            ),

            darkTheme: ThemeData(
                scaffoldBackgroundColor: HexColor('333739'),
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                  actionsIconTheme: IconThemeData(color: Colors.white),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  backgroundColor: HexColor('333739'),
                  titleTextStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.light,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    unselectedItemColor: Colors.grey,
                    selectedItemColor: Colors.deepOrange,
                    backgroundColor: HexColor('333739')
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white,
                    )
                )
            ),
            home:AnimatedSplashScreen(
              nextScreen: Newslayout(),
              duration: 3000,
              splash: 'images/images.png',

            ),

          );
        },
      ),
    );

  }
}