import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:store_api/data/db_helper.dart';
import 'package:store_api/helpers/route_helper.dart';
import 'package:store_api/providers/home_provider.dart';
import 'package:store_api/ui/screens/cart_screen.dart';
import 'package:store_api/ui/screens/favorite_products_screen.dart';
import 'package:store_api/ui/screens/home_screen.dart';
import 'package:store_api/ui/screens/product_details_screen.dart';
import 'package:store_api/ui/screens/splash_screen.dart';
import 'package:store_api/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: ThemeData(
          primarySwatch: primaryColor,
          fontFamily: 'Lato',
        ),
        navigatorKey: RouteHelper.routeHelper.navigatorKey,
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
          FavoriteProductsScreen.routeName: (context) =>
              FavoriteProductsScreen(),
          CartScreen.routeName: (context) => CartScreen(),
        },
      ),
    );
  }
}
