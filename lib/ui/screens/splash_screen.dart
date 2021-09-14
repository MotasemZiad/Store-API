import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api/helpers/route_helper.dart';
import 'package:store_api/providers/home_provider.dart';
import 'package:store_api/ui/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider..getAllCategories();
      homeProvider.getAllProducts();
      RouteHelper.routeHelper.pushReplacementNamed(HomeScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 120.0,
        ),
      ),
    );
  }
}
