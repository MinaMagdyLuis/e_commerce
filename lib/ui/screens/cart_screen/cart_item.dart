import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/data/model/cart_product.dart';
import 'package:e_commerce/ui/screens/utils/app_colors.dart';
import 'package:e_commerce/ui/screens/utils/base_state.dart';
import 'package:e_commerce/ui/shared_view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatefulWidget {
  final CartProduct cartProduct;

  const CartItem({super.key, required this.cartProduct});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late CartViewModel viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartViewModel, BaseState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 24, horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            height: MediaQuery.of(context).size.height * .15,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  width: MediaQuery.of(context).size.height * .15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.cartProduct.product?.imageCover ?? "",
                    fit: BoxFit.fill,
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.cartProduct.product?.title ?? "",
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(
                                      fontSize: 18,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                maxLines: 1, // show only one line
                                overflow: TextOverflow.ellipsis, // add "..."
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                viewModel.removeProductFromCart(
                                  widget.cartProduct.product?.id ?? "",
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "EGB ${widget.cartProduct.price}",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    fontSize: 14,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Spacer(),
                            _buildAddButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              viewModel.removeProductFromCart(
                widget.cartProduct.product?.id ?? "",
              );
            },
            icon: Icon(
              Icons.remove_circle_outline_rounded,
              color: AppColors.white,
              size: 30,
            ),
          ),

          // Quantity number
          Text(
            "${widget.cartProduct.count}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          // Plus button
          IconButton(
            onPressed: () {
              viewModel.addProductToCart(widget.cartProduct.product?.id ?? "");
            },
            icon: Icon(
              Icons.add_circle_outline_rounded,
              color: AppColors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }


}
