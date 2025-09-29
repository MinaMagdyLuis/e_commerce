import 'package:e_commerce/ui/screens/utils/app_colors.dart';
import 'package:e_commerce/ui/screens/utils/base_state.dart';
import 'package:e_commerce/ui/shared_view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/data/model/product_dm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:readmore/readmore.dart';

import '../cart_screen/cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = 'ProductDetailsScreen';

  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late CartViewModel viewModel;

  String? _selectedColor;
  int? _selectedSize;
  late ProductDM product;

  final List<int> _availableSizes = [38, 39, 40, 41, 42];
  final List<Color> _availableColors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.redAccent,
  ];

  @override
  void initState() {
    super.initState();
    _selectedSize = _availableSizes[2];
    _selectedColor = _availableColors[1].toString();
    viewModel = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    product = ModalRoute.of(context)!.settings.arguments as ProductDM;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.grey, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ImageSlideshow(
                          initialPage: 0,
                          indicatorColor: AppColors.primary,
                          indicatorBackgroundColor: AppColors.white,
                          indicatorBottomPadding: 20,
                          autoPlayInterval: 3000,
                          isLoop: true,
                          children: product.images!
                              .map(
                                (url) => Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.title ?? 'No Title',
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(
                                  fontSize: 18,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Text(
                          'EGP ${product.price?.toStringAsFixed(0) ?? '0'}',
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.transparent,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: AppColors.primary,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  'Sold ${product.sold?.toStringAsFixed(1) ?? "0"}',
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .copyWith(
                                        fontSize: 18,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Icon(Icons.star, color: Colors.yellow),
                              SizedBox(width: 4),
                              Text(
                                '${product.ratingsAverage}(${product.ratingsQuantity})',
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(
                                      fontSize: 18,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    _buildDescription(),
                    const SizedBox(height: 16),
                    _buildSizes(),
                    const SizedBox(height: 16),
                    _buildColors(),
                  ],
                ),
              ),
            ),
            BlocBuilder<CartViewModel, BaseState>(
              builder: (context, state) {
                return Row(
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
                          'EGP ${product.price! * (viewModel.isCartProduct(product)!.count??0) }',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: viewModel.isCartProduct(product) == null
                          ? _buildAddToCartWidget(context)
                          : _buildAddButton(),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
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
      title: const Text('Product Details'),
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

  /// 🔹 Fixed Quantity Selector

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 18,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        ReadMoreText(
          product.description ?? 'No description available.',
          trimMode: TrimMode.Line,
          trimCollapsedText: "Show More",
          trimExpandedText: "Show Less",
          trimLines: 2,
          moreStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 18,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
          lessStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 14,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
          style: TextStyle(
            fontSize: 14,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSizes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Size',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _availableSizes.length,
            itemBuilder: (context, index) {
              final size = _availableSizes[index];
              return _buildSizeOption(size);
            },
            separatorBuilder: (context, index) => const SizedBox(width: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildSizeOption(int size) {
    final isSelected = size == _selectedSize;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSize = size;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          '$size',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildColors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _availableColors.length,
            itemBuilder: (context, index) {
              final color = _availableColors[index];
              return _buildColorOption(color);
            },
            separatorBuilder: (context, index) => const SizedBox(width: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildColorOption(Color color) {
    final isSelected = color.toString() == _selectedColor;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color.toString();
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          if (isSelected)
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: isSelected && color != Colors.white
                  ? const Icon(Icons.check, color: Colors.white)
                  : null,
            ),
        ],
      ),
    );
  }

  Widget _buildAddToCartWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        viewModel.addProductToCart(product.id!);
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
          Text("Add to cart", style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
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
              viewModel.removeProductFromCart(product.id!);
            },
            icon: Icon(
              Icons.remove_circle_outline_rounded,
              color: AppColors.white,
              size: 30,
            ),
          ),

          // Quantity number
          Text(
            "${viewModel.isCartProduct(product)?.count}" ?? "",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          // Plus button
          IconButton(
            onPressed: () {
              viewModel.addProductToCart(product.id!);
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
