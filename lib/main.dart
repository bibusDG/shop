import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/core/bindings/product_category_bindings.dart';
import 'package:shop/core/bindings/user_bindings.dart';
import 'package:shop/features/product_categories/presentation/pages/product_category_page.dart';
import 'package:shop/features/user_auth/presentation/pages/registration_page.dart';
import 'package:shop/firebase_options.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import 'core/start_page.dart';

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
      builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: const [
            Breakpoint(start: 0, end: 450, name: MOBILE),
            Breakpoint(start: 451, end: 800, name: TABLET),
          ]
      ),
      initialRoute: '/start_page',
      getPages: [
        GetPage(name:'/product_category', page :() => const ProductCategoryPage(), binding: ProductCategoryBindings()),
        GetPage(name: '/start_page', page: () => const StartPage()),
        GetPage(name: '/registration_page', page: () => const RegistrationPage(), binding: UserBindings()),
      ],
      theme: ThemeData.dark(),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      //   useMaterial3: true,
      // ),
    );
  }
}

