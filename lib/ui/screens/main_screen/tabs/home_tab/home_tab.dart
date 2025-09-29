import 'package:e_commerce/data/model/cart_dm.dart';
import 'package:e_commerce/data/model/category_dm.dart';
import 'package:e_commerce/data/model/product_dm.dart';
import 'package:e_commerce/domain/use_cases/get_all_categories_usecase.dart';
import 'package:e_commerce/domain/use_cases/get_all_products_usecase.dart';
import 'package:e_commerce/ui/screens/cart_screen/cart_screen.dart';
import 'package:e_commerce/ui/screens/main_screen/tabs/home_tab/home_view_model_cubit.dart';
import 'package:e_commerce/ui/screens/utils/app_colors.dart';
import 'package:e_commerce/ui/screens/utils/base_state.dart';
import 'package:e_commerce/ui/screens/widgets/category_item.dart';
import 'package:e_commerce/ui/screens/widgets/error_widget.dart';
import 'package:e_commerce/ui/screens/widgets/loading_widget.dart';
import 'package:e_commerce/ui/screens/widgets/product_item.dart';
import 'package:e_commerce/ui/shared_view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatefulWidget {
   const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late HomeViewModelCubit viewModel;

  late CartViewModel cartViewModel;

  @override
  void initState() {
    super.initState();
    cartViewModel = BlocProvider.of(context, listen: false);
    viewModel = BlocProvider.of(context);

    viewModel.loadCategories();
    viewModel.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: MediaQuery.of(context).size.height * .28,
                child: BlocBuilder<GetAllCategoriesUseCase, BaseState>(
                  bloc: viewModel.getAllCategoriesUseCase,
                  builder: (context, state) {
                    if (state is BaseInitialState) {
                      return const SizedBox(); // or a placeholder widget
                    } else if (state is BaseSuccessState<List<CategoryDM>>) {
                      return buildCategoryGridView(state.data!);
                    } else if (state is BaseLoadingState) {
                      return LoadingWidget();
                    } else {
                      return ErrorView();
                    }
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .30,
                child: BlocBuilder<GetAllProductsUseCase, BaseState>(
                  bloc: viewModel.getAllProductsUseCase,

                  builder: (context, state) {
                    if (state is BaseInitialState) {
                      return const SizedBox(); // or a placeholder widget
                    } else if (state is BaseSuccessState<List<ProductDM>>) {
                      return buildProductListView(state.data!);
                    } else if (state is BaseLoadingState) {
                      return LoadingWidget();
                    } else {
                      return ErrorView();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildCategoryGridView(List<CategoryDM> list) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: list.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return CategoryItem(categoryDM: list[index]);
      },
    );
  }

  buildProductListView(List<ProductDM> list) {
    return BlocBuilder<CartViewModel, dynamic>(
      builder: (context, state) {
        CartDM? cartDM = cartViewModel.cartDM;

        if (state is! BaseLoadingState) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              var product = list[index];


              return ProductItem(
                productDM: product,
                isCartProduct: cartViewModel.isCartProduct(product)!=null,
              );
            },
          );
        } else {}
        return LoadingWidget();
      },
    );
  }
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text('Home'),
      titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: 20,
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,

      actions: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
        ),
      ],
    );
  }

}
