import 'package:flutter/material.dart';

import '../../../commons/app_colors.dart';
// import '../../app_colors.dart';
// import '../../models/food_item.dart';
// import '../../utils/food_list.dart';
// import '../upload_fashion_groceries_page.dart';
// import '../upload_food_screen.dart';
// import 'products_thread/product_detail_page.dart';

class CommunitiesFragment extends StatelessWidget {
  const CommunitiesFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenPadding = size.width * 0.03;
    final theme = Theme.of(context).textTheme;

    return Container(
      color: AppColors.backgroundColor,
      child: Stack(
        children: [
          // Main content
          Column(
            children: [
              Container(
                color: AppColors.backgroundColor,
                height: 50,
                width: size.width,
                child: Center(
                  child: Text(
                    'Products',
                    style:
                        theme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // Expanded(
              //   child: GridView.builder(
              //     padding: EdgeInsets.all(screenPadding),
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: size.width < 600 ? 2 : 4,
              //       crossAxisSpacing: screenPadding,
              //       mainAxisSpacing: screenPadding,
              //       childAspectRatio: 0.8,
              //     ),
              //     itemCount: foodItems.length,
              //     itemBuilder: (context, index) {
              //       final food = foodItems[index];
              //       return GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => const ProductDetailPage(),
              //             ),
              //           );
              //         },
              //         child: FoodItem(
              //           imageUrl: food['imageUrl'],
              //           description: food['description'],
              //           price: food['price'],
              //           rating: food['rating'],
              //           quantity: food['quantity'],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
          // Add product button
          // Positioned(
          //   bottom: size.width * 0.01,
          //   right: size.width * 0.03,
          //   child: GestureDetector(
          //     onLongPress: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const UploadFashionScreen(),
          //         ),
          //       );
          //     },
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const UploadFoodScreen(),
          //         ),
          //       );
          //     },
          //     child: Container(
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.orange.withOpacity(0.9),
          //       ),
          //       height: 50,
          //       width: 50,
          //       child: Center(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             const Icon(Icons.add, color: Colors.white),
          //             Text(
          //               'Add',
          //               style: theme.titleSmall?.copyWith(
          //                 color: Colors.white,
          //                 fontSize: size.width * 0.023,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
