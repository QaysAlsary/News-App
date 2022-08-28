import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/models/dio_helper.dart';
import 'package:news_app/screens/home/news_layout.dart';
import 'models/cache_helper.dart';
import 'cubit/main_cubit.dart';
import 'cubit/main_states.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()),
        BlocProvider(
            create: (context) =>
                MainCubit()..changeAppMode(fromShared: isDark)),
      ],
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primaryColor: Colors.orange,
                primarySwatch: Colors.orange,
                appBarTheme: const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    )),
                iconTheme: const IconThemeData(color: Colors.orange),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.orange,
                  elevation: 20.0,
                  backgroundColor: Colors.white,
                ),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ))),
            darkTheme: ThemeData(
                scaffoldBackgroundColor: Colors.grey[800],
                primaryColor: Colors.orange,
                primarySwatch: Colors.orange,
                appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.grey[800],
                      statusBarIconBrightness: Brightness.light,
                    ),
                    backgroundColor: Colors.grey[800],
                    elevation: 0.0,
                    titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    iconTheme: const IconThemeData(
                      color: Colors.white,
                    )),
                iconTheme: const IconThemeData(color: Colors.orange),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.orange,
                    unselectedItemColor: Colors.grey[400],
                    elevation: 20.0,
                    backgroundColor: Colors.grey[800]),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ))),
            themeMode: MainCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const NewsLayyout(),
          );
        },
      ),
    );
  }
}

