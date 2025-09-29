import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/data/model/category_dm.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final CategoryDM categoryDM;

  const CategoryItem({super.key, required this.categoryDM});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle category tap here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selected: ${categoryDM.name ?? ""}")),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),

          /// Circle image with safe loading & fallback
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade200,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: (categoryDM.image?.isNotEmpty ?? false)
                    ? categoryDM.image!
                    : "https://dummyimage.com/100x100/cccccc/000000&text=No+Image",
                fit: BoxFit.cover,
                width: 60,
                height: 60,
                placeholder: (context, url) => const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.broken_image,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          const Spacer(),

          /// Category name
          Text(
            categoryDM.name ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
