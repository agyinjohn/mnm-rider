import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:m_n_m_rider/screens/new_screens/on_boarding_screen.dart';
import 'package:m_n_m_rider/screens/new_screens/verification_page.dart';
import 'package:m_n_m_rider/utils/routes.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/new_screens/dashboard_fragments/dashboard_page.dart';
import 'screens/new_screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await LocationService.startService();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // bool isLoading = true;

  // //  bool isLoading = true;

  // @override
  // void initState() {
  //   super.initState();
  //   // Load user data from SharedPreferences on app start
  //   getUserToken();
  // }

  // getUserToken() async {
  //   await ref.read(authProvider.notifier).loadToken();
  //   setState(() {
  //     isLoading = false; // Set loading to false once user is loaded
  //   });
  // }
  bool isTokenValid = false;
  String? userRole;
  bool isloading = true;
  bool isUser = false;
  @override
  void initState() {
    super.initState();
    // authService.getUserData(context);
    checkTokenValidity();
  }

  Future<void> checkTokenValidity() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final isUserLoggedIn = preferences.getBool('isUser') ?? false;
    final token = preferences.getString('token');
    setState(() {
      isloading = true;
      isUser = isUserLoggedIn;
    });
    try {
      if (token != null && !JwtDecoder.isExpired(token)) {
        // Decode token to get user role
        final decodedToken = JwtDecoder.decode(token);
        setState(() {
          isTokenValid = true;
          userRole =
              decodedToken['role']; // Assuming 'role' is in the token payload
          isloading = false;
        });
      }
    } catch (e) {
      setState(() {
        isTokenValid = false;
        isloading = false;
      });
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(authProvider.notifier).isAuthenticated();
    // print(user)
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M&M Delivery Services',
      home: isTokenValid
          ? (userRole == 'dispatcher'
              ? const DashboardPage()
              : const SignInScreen())
          : isloading
              ? const Scaffold(body: Center(child: NutsActivityIndicator()))
              : isUser
                  ? const SignInScreen()
                  : const OnboardingScreen(),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 252, 99, 43)),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => onGenerateRoute(settings, ref),
    );
  }
}





// 1. Electronics
// Common Fields:
// Name
// Price
// Description
// Images
// Brand
// Warranty Period
// Condition (New, Used, Refurbished)
// Subcategories and Dynamic Fields:
// Phones

// Storage
// RAM
// Operating System
// Screen Size
// Battery Capacity
// Camera Specifications
// Laptops

// Processor
// RAM
// Storage
// Graphics Card
// Operating System
// Screen Size
// Battery Life
// Tablets

// Operating System
// RAM
// Storage
// Battery Capacity
// Screen Size
// Cameras

// Megapixels
// Lens Type
// Zoom Level
// Sensor Type
// Video Resolution
// Home Appliances

// Type of Appliance (Refrigerator, Washing Machine, Oven)
// Energy Rating
// Capacity (Liters for refrigerators, Kg for washing machines)
// Power Consumption
// Computer Accessories

// Accessory Type (Mouse, Keyboard, External HDD)
// Compatibility
// Connectivity (Wired, Wireless)
// Smartwatches

// Operating System
// Battery Life
// Display Type (AMOLED, LCD)
// Health Features (Heart Rate Monitor, GPS)
// Headphones

// Type (In-Ear, Over-Ear)
// Connectivity (Wired, Wireless)
// Battery Life (for wireless)
// 2. Fashion & Apparel
// Common Fields:
// Name
// Price
// Description
// Images
// Brand
// Material
// Size Guide
// Subcategories and Dynamic Fields:
// Men's Clothing

// Size
// Fit (Slim, Regular, Loose)
// Sleeve Length
// Women's Clothing

// Size
// Fit
// Sleeve Length
// Dress Length
// Kids' Clothing

// Size
// Age Group
// Footwear

// Size
// Material
// Type (Casual, Formal, Sports)
// Accessories

// Type (Bags, Belts, Jewelry)
// Material
// Dimensions
// 3. Health & Beauty
// Common Fields:
// Name
// Price
// Description
// Images
// Brand
// Ingredients
// Subcategories and Dynamic Fields:
// Skincare
// Skin Type
// Use (Day, Night
// , All-Purpose)

// Key Benefits (Anti-Aging, Moisturizing)

// Haircare

// Hair Type
// Key Ingredients
// Use (Shampoo, Conditioner, Hair Mask)
// Makeup

// Type (Foundation, Lipstick, Mascara)
// Shade/Color
// Finish (Matte, Glossy)
// Personal Care

// Product Type (Deodorant, Razor, Toothpaste)
// Skin Compatibility
// Features (Antibacterial, Sensitive Skin)
// Fitness Products

// Product Type (Weights, Yoga Mats)
// Weight/Size
// Material
// Supplements

// Type (Vitamins, Proteins, Minerals)
// Key Ingredients
// Serving Size
// Expiration Date
// 4. Home & Kitchen
// Common Fields:
// Name
// Price
// Description
// Images
// Brand
// Material
// Subcategories and Dynamic Fields:
// Furniture

// Dimensions
// Material (Wood, Metal)
// Weight Capacity
// Bedding

// Size (Twin, Queen, King)
// Material (Cotton, Polyester)
// Thread Count
// Kitchenware

// Material (Stainless Steel, Ceramic)
// Type (Cookware, Cutlery)
// Decor

// Material (Wood, Glass)
// Dimensions
// Color
// Storage Solutions

// Capacity
// Material (Plastic, Metal)
// Type (Boxes, Shelves)
// Home Improvement

// Type (Lighting, Plumbing)
// Voltage/Power
// 5. Groceries & Supermarkets
// Common Fields:
// Name
// Price
// Description
// Images
// Brand
// Weight/Volume
// Subcategories and Dynamic Fields:
// Fresh Produce

// Type (Fruits, Vegetables)
// Organic or Non-Organic
// Expiration Date
// Beverages

// Type (Juice, Soft Drink)
// Volume (Liters)
// Expiration Date
// Snacks

// Weight
// Ingredients
// Expiration Date
// Dairy Products

// Type (Milk, Cheese, Yogurt)
// Expiration Date
// Packaged Foods

// Weight
// Ingredients
// Expiration Date
// Household Items

// Type (Cleaning, Detergents)
// Quantity
// 6. Automotive
// Common Fields:
// Name
// Price
// Description
// Images
// Brand
// Subcategories and Dynamic Fields:
// Car Accessories

// Compatibility (Vehicle Type)
// Material
// Motorbike Accessories

// Compatibility (Bike Type)
// Material
// Car Parts

// Part Type (Brakes, Engine, Suspension)
// Compatibility (Make, Model)
// Tires

// Size (Diameter, Width)
// Compatibility (Car, Truck)
// Tools and Equipment

// Type (Wrench, Jack)
// Material
// 7. Baby & Kids
// Common Fields:
// Name
// Price
// Description
// Images
// Brand
// Subcategories and Dynamic Fields:
// Baby Gear

// Age Group
// Type (Stroller, Car Seat)
// Weight Capacity
// Toys

// Age Group
// Material
// Baby Food

// Expiration Date
// Ingredients
// Diapers & Baby Care

// Size
// Age Range
// Skin Compatibility
// 8. Books & Stationery
// Common Fields:
// Name
// Price
// Description
// Images
// Author/Brand
// Subcategories and Dynamic Fields:
// Books

// Genre
// Author
// ISBN
// Office Supplies

// Type (Pen, Paper, Stapler)
// Material
// Stationery

// Type (Notebook, Pen)
// Paper Size (A4, A5)
// Art & Craft Supplies

// Material (Paper, Paint)
// Type (Canvas, Paint)
// 9. Sports & Outdoors
// Common Fields:
// Name
// Price
// Description
// Images
// Brand
// Subcategories and Dynamic Fields:
// Sports Equipment

// Type (Bicycle, Ball, Weights)
// Material
// Outdoor Gear

// Type (Camping, Hiking)
// Size/Capacity
// Fitness Apparel

// Size
// Material
// Gender
// 10. Toys & Games
// Common Fields:
// Name
// Price
// Description
// Images
// Brand
// Subcategories and Dynamic Fields:
// Educational Toys

// Age Range
// Material
// Features
// Action Figures

// Size
// Material
// Puzzles

// Number of Pieces
// Board Games

// Age Range
// Number of Players
// Video Games

// Platform (PC, Xbox, PlayStation)
// Genre
// 11. Fast Food & Beverages
// Common Fields:
// Name
// Price
// Description
// Images
// Subcategories and Dynamic Fields:
// Fast Foods

// Type (Pizza, Burger)
// Ingredients
// Size
// Beverages

// Type (Soft Drink, Juice)
// Volume
// Snacks

// Ingredients
// Expiration Date
// Bakery Items

// Type (Bread, Pastry)
// Ingredients
// 12. Health & Medicine
// Common Fields:
// Name
// Price
// Description
// Images
// Brand
// Subcategories and Dynamic Fields:
// Prescription Drugs

// Dosage
// Expiration Date
// OTC Medications

// Dosage
// Expiration Date
// Vitamins & Supplements

// Ingredients
// Dosage
// Medical Equipment

// Type (Thermometer, Blood Pressure Monitor)
// Specifications
// 13. Jewelry & Accessories
// Common Fields:
// Name
// Price
// Description
// Images
// Brand
// Subcategories and Dynamic Fields:
// Watches

// Type (Analog, Digital)
// Material
// Necklaces

// Material
// Length
// Earrings

// Material
// Style
// Rings

// Material
// Size
// Sunglasses

// Lens Type (Polarized, Non-Polarized)
// 14. Pet Supplies
// Common Fields:
// Name
// Price
// Description
// Images
// Brand
// Subcategories and Dynamic Fields:
// Pet Food

// Animal Type
// Ingredients