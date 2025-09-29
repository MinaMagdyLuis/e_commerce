import 'package:bloc/bloc.dart';
import 'package:e_commerce/ui/screens/main_screen/tabs/categories_tab/categories_tab.dart';
import 'package:e_commerce/ui/screens/main_screen/tabs/fav_tab/fav_tab.dart';
import 'package:e_commerce/ui/screens/main_screen/tabs/home_tab/home_tab.dart';
import 'package:e_commerce/ui/screens/main_screen/tabs/profile_tab/profile_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainViewModel extends Cubit<MainViewModelState> {
  int currentIndex = 0;
  List<Widget> tabs = [HomeTab(), CategoriesTab(), FavTab(), ProfileTab()];

  MainViewModel() : super(MainViewModelInitial());

  set currentTab(int newIndex) {
    currentIndex = newIndex;
    emit(MainViewModelInitial());
  }
}

@immutable
sealed class MainViewModelState {}

final class MainViewModelInitial extends MainViewModelState {}
