import 'package:e_commerce/domain/di/di.dart';
import 'package:e_commerce/ui/screens/main_screen/main_view_model_cubit.dart';
import 'package:e_commerce/ui/screens/utils/app_assets.dart';
import 'package:e_commerce/ui/screens/utils/app_colors.dart';
import 'package:e_commerce/ui/shared_view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'main_screen';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainViewModel viewModel = getIt();
  @override
  void initState() {
    super.initState();
    CartViewModel viewModel=BlocProvider.of(context);
    viewModel.loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainViewModel, MainViewModelState>(
      bloc: viewModel,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text("Home Screen"), centerTitle: true),
          body: viewModel.tabs[viewModel.currentIndex],
          bottomNavigationBar: Theme(
            data: ThemeData(canvasColor: Theme.of(context).primaryColor),
            child: BottomNavigationBar(
              items: [
                buildBottomNavigationBar(
                  AppAssets.icHome,
                  viewModel.currentIndex == 0,
                ),
                buildBottomNavigationBar(
                  AppAssets.icCategory,
                  viewModel.currentIndex == 1,
                ),
                buildBottomNavigationBar(
                  AppAssets.icFav,
                  viewModel.currentIndex == 2,
                ),
                buildBottomNavigationBar(
                  AppAssets.icProfile,
                  viewModel.currentIndex == 3,
                ),
              ],
              backgroundColor: AppColors.primary,
              unselectedItemColor: AppColors.white,
              selectedItemColor: AppColors.white,
              onTap: (value) {

                viewModel.currentTab = value;

              },
              showSelectedLabels: false,
            ),
          ),
        );
      },
    );
  }

  buildBottomNavigationBar(String asset, bool isSelected) {
    return BottomNavigationBarItem(
      label: '',
      icon: isSelected
          ? CircleAvatar(
              radius: isSelected ? 20 : 0,
              backgroundColor: isSelected
                  ? AppColors.white
                  : AppColors.transparent,

              child: ImageIcon(AssetImage(asset), size: 30),
            )
          : ImageIcon(AssetImage(asset), size: 30),
    );
  }
}
