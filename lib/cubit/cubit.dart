import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/screens/business/business.dart';
import 'package:news_app/screens/science/science.dart';
import 'package:news_app/screens/sport/sport.dart';
import '../models/dio_helper.dart';
class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_football),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const SportScreen(),
    const ScienceScreen(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'ae',
      'category': 'business',
      'apiKey': 'YOUR API KEY',
    }).then((value) {
      business = value.data['articles'];

      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      SnackBar(
          content: Text('error in getting business news ${error.toString()}'));
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'ae',
        'category': 'sports',
        'apiKey': 'YOUR API KEY',
      }).then((value) {
        sports = value.data['articles'];

        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        SnackBar(
            content: Text('error in getting sports news ${error.toString()}'));
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'ae',
        'category': 'science',
        'apiKey': 'YOUR API KEY',
      }).then((value) {
        science = value.data['articles'];

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        SnackBar(
            content: Text('error in getting science news ${error.toString()}'));
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void getSearch({
    required var searchKey,
  }) {
    emit(NewsGetSearchLoadingState());
    search = [];

    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$searchKey',
      'apiKey': 'YOUR API KEY',
    }).then((value) {
      search = value.data['articles'];

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      SnackBar(
          content: Text('error in getting search results ${error.toString()}'));
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
