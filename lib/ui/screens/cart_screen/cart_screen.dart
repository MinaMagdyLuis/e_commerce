import 'package:e_commerce/data/model/product_dm.dart';
import 'package:e_commerce/ui/screens/cart_screen/cart_item.dart';
import 'package:e_commerce/ui/screens/utils/app_colors.dart';
import 'package:e_commerce/ui/screens/utils/base_state.dart';
import 'package:e_commerce/ui/shared_view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = "cartScreen";

  CartScreen({super.key});

  late CartViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = BlocProvider.of(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<CartViewModel, BaseState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return CartItem(
                      cartProduct: viewModel.cartDM!.cartProducts![index],
                    );
                  },
                  itemCount: viewModel.cartDM?.cartProducts?.length??0,
                ),
              ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
            child: Row(
            children: [
            Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text(
            'Total price',
            style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
            'EGP ${viewModel.cartDM?.totalCartPrice??""} ',
            style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            ),
            ),
            ],
            ),
            const SizedBox(width: 24),
            _buildAddToCartWidget(context),          ],
            ),
          )
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text('Cart'),
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
      ],
    );
  }
  Widget _buildAddToCartWidget(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          // TODO

        },

        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          textStyle: const TextStyle(fontSize: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.add_shopping_cart_outlined, color: AppColors.white),
            Text("Check Out", style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }

}
