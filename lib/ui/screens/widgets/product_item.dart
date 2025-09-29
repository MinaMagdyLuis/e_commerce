import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/data/model/product_dm.dart';
import 'package:e_commerce/ui/screens/product_details_screen/product_details_screen.dart';
import 'package:e_commerce/ui/screens/utils/app_assets.dart';
import 'package:e_commerce/ui/screens/utils/app_colors.dart';
import 'package:e_commerce/ui/screens/widgets/loading_widget.dart';
import 'package:e_commerce/ui/shared_view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatefulWidget {

  final ProductDM productDM;
 final bool isCartProduct ;

   const ProductItem({super.key, required this.productDM,required this.isCartProduct});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,arguments: widget.productDM);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.lightBlue,

          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade200, width: 1),
        ),
        width: MediaQuery.of(context).size.width * .4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.productDM.imageCover ?? "",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => LoadingWidget(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .13,
                  httpHeaders: {"Accept": "image/*"},
                ),
                Image.asset(AppAssets.icFav),
              ],
            ),
            Spacer(),
            Text(
              widget.productDM.title ?? "",
              textAlign: TextAlign.start,
              maxLines: 2,
              style: TextStyle(
                fontSize: 14,
                height: 1,

                fontWeight: FontWeight.w500,
                color: Colors.blue.shade800,
              ),
            ),
            Spacer(),
            Row(
              children: [
                Text("Review (${widget.productDM.ratingsAverage})"),
                Spacer(),
                Icon(Icons.star, color: Colors.amberAccent),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text("EGB ${widget.productDM.price.toString()}"),
                Spacer(),
                SizedBox(
                  width: 30,
                  height: 30,

                  child: FloatingActionButton(  heroTag: null, // disables Hero animation

                    onPressed: () {
                      CartViewModel viewModel=BlocProvider.of(context);
                      if (widget.isCartProduct) {
                        viewModel.removeProductFromCart(widget.productDM.id!);
                      }  else{
                        viewModel.addProductToCart(widget.productDM.id!);
                      }
                    },
                    backgroundColor: AppColors.primary,
                    child: Icon(widget.isCartProduct?Icons.remove: Icons.add, color: AppColors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
