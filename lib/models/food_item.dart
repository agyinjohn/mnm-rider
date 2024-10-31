import 'package:flutter/material.dart';

import '../commons/app_colors.dart';
import 'package:iconly/iconly.dart';

class FoodItem extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String price;
  final String rating;
  final int quantity;

  const FoodItem({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.rating,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;

    return Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(size.width * 0.03),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(size.width * 0.03)),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: size.height * 0.18,
              ),
              // 'assets/images/loading-image.gif',
              // image: imageUrl,
              // fit: BoxFit.cover,
              // height: size.height * 0.2,
              // width: double.infinity,
            ),
            // FadeInImage.assetNetwork(
            //   placeholder:
            //   'assets/images/loading-image.gif',
            //   image: imageUrl,
            //   fit: BoxFit.cover,
            //   height: size.height * 0.2,
            //   width: double.infinity,
            // ),
            // ),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Text(
                'GH¢ $price',
                style: theme.bodyMedium?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Row(
                children: [
                  Text(
                    'Quantity: $quantity',
                    style: theme.labelSmall,
                  ),
                  const Spacer(),
                  Icon(
                    IconlyBold.star,
                    color: Colors.amber,
                    size: size.width * 0.03,
                  ),
                  SizedBox(width: size.width * 0.02),
                  Text(
                    rating,
                    style:
                        theme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
          // ),
        ));
  }
}
