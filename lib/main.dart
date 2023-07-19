import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/enums/enums.dart';
import 'package:my_tune_admin/provider/banner_list_provider/banner_list_page_provider.dart';
import 'package:my_tune_admin/provider/notification_provider/notification_provider.dart';
import 'package:my_tune_admin/provider/products_page_provider/category_search_provider.dart';
import 'package:my_tune_admin/provider/products_page_provider/products_page_provider.dart';
import 'package:my_tune_admin/provider/todays_release/product_search_provider.dart';
import 'package:my_tune_admin/provider/todays_release/todays_release_provider.dart';
import 'package:my_tune_admin/provider/uploads_page_provider/uploads_page_provider.dart';
import 'package:my_tune_admin/provider/users_page_provider.dart/user_page_provider.dart';
import 'package:my_tune_admin/screens/admn_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBjkOVxfJtmhImKiPkWypKm6WaCnzzds9g",
        authDomain: "my-tune-admin.firebaseapp.com",
        projectId: "my-tune-admin",
        storageBucket: "my-tune-admin.appspot.com",
        messagingSenderId: "425408728029",
        appId: "1:425408728029:web:46a57dde111b7c9bdfc434"),
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BannerListPageProvider>(
          create: ((context) => BannerListPageProvider()..getBannerFromDb()),
        ),
        ChangeNotifierProvider<NotificationProvider>(
          create: (context) => NotificationProvider(),
        ),
        ChangeNotifierProvider<UserPageProvider>(
          create: (context) => UserPageProvider()
            ..getUsersByLimit(
              loadstate: GetDataState.normal,
            ),
        ),
        ChangeNotifierProvider<UploadsPageProvider>(
          create: (_) => UploadsPageProvider()
            ..getCategoriesByLimit(
              categoryState: GetDataState.normal,
            ),
        ),
        ChangeNotifierProvider<ProductPageProvider>(
          create: (_) => ProductPageProvider(),
        ),
        ChangeNotifierProvider<CategorySearchProvider>(
            create: (_) => CategorySearchProvider()),
        ChangeNotifierProvider<ChangeRadioValue>(
          create: (_) => ChangeRadioValue(),
        ),
        ChangeNotifierProvider<TodaysReleaseProvider>(
          create: (context) => TodaysReleaseProvider()
            ..getTodaysReleaseByLimit(
              productState: GetDataState.normal,
            ),
        ),
        ChangeNotifierProvider<ProductSearchProvider>(
          create: (context) => ProductSearchProvider(),
        )
      ],
      child: MaterialApp(
        title: "MY Tune Admin",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AdminScreen(),
      ),
    );
  }
}
