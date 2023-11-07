import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shop/core/bindings/basket_bindings.dart';
import 'package:shop/core/bindings/modify_user_bindings.dart';
import 'package:shop/core/bindings/order_bindings.dart';
import 'package:shop/core/bindings/product_category_bindings.dart';
import 'package:shop/core/bindings/user_bindings.dart';
import 'package:shop/features/order/presentation/pages/allOrders_page.dart';
import 'package:shop/features/order/presentation/pages/order_detail_page.dart';
import 'package:shop/features/product/presentation/pages/create_product_page.dart';
import 'package:shop/features/product/presentation/pages/products_in_category_page.dart';
import 'package:shop/features/product_categories/presentation/pages/create_new_category_page.dart';
import 'package:shop/features/product_categories/presentation/pages/product_category_page.dart';
import 'package:shop/features/user_auth/presentation/pages/registration_page.dart';
import 'package:shop/features/user_auth/presentation/pages/user_profile_page.dart';
import 'package:shop/firebase_options.dart';

import 'core/bindings/product_bindings.dart';
import 'core/start_page.dart';
import 'features/basket/presentation/pages/basket_page.dart';
import 'features/order/presentation/pages/order_page.dart';
import 'features/product/presentation/pages/product_details_page.dart';
import 'features/user_auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Shop());
}

class Shop extends StatelessWidget {
  const Shop ({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      initialRoute: '/start_page',
      getPages: [
        GetPage(name: '/login_page', page: () => const LoginPage()),
        GetPage(name:'/product_category', page :() => const ProductCategoryPage(), bindings: [ProductCategoryBindings(), ProductBindings()]),
        GetPage(name: '/start_page', page: () => const StartPage(), bindings: [BasketBindings(), UserBindings(), ModifyUserBindings()]),
        GetPage(name: '/registration_page', page: () => const RegistrationPage()),
        GetPage(name: '/products_in_category_page', page: ()=> const ProductsInCategoryPage(), binding: ProductBindings()),
        GetPage(name: '/product_details_page', page: () => const ProductDetailsPage(), binding: ProductBindings()),
        GetPage(name: '/basket_page', page: () => const BasketPage(), binding: OrderBindings()),
        GetPage(name: '/order_page', page: () => const OrderPage()),
        GetPage(name: '/allOrders_page', page: () => const AllOrdersPage(), binding: OrderBindings()),
        GetPage(name: '/user_profile_page', page: () => const UserProfilePage(), binding: ModifyUserBindings()),
        GetPage(name: '/order_detail_page', page: () => const OrderDetailPage()),
        GetPage(name: '/create_product_page', page: () => const CreateProductPage()),
        GetPage(name: '/create_new_category_page', page: () => const CreateNewCategoryPage()),
      ],
      theme: ThemeData.light(),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      //   useMaterial3: true,
      // ),
    );
  }
}

