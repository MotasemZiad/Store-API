import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api/helpers/route_helper.dart';
import 'package:store_api/models/product.dart';
import 'package:store_api/providers/home_provider.dart';
import 'package:store_api/ui/screens/product_details_screen.dart';
import 'package:store_api/ui/widgets/product_item.dart';
import 'package:store_api/utils/constants.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          List<ProductResponse> products = homeProvider.cartProducts;
          return products.length < 1
              ? Center(
                  child: Text(
                    'Empty Cart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.only(
                    left: marginHorizontal,
                    right: marginHorizontal,
                    bottom: marginVertical,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 8,
                    // childAspectRatio: 7 / 8,
                  ),
                  itemCount: homeProvider.cartProducts.length,
                  itemBuilder: (context, index) {
                    return ProductItem(
                      title: homeProvider.cartProducts[index].title,
                      imageUrl: homeProvider.cartProducts[index].image,
                      price: homeProvider.cartProducts[index].price,
                      onTap: () {
                        homeProvider.getSpecificProduct(
                          homeProvider.categoryProducts[index].id,
                        );
                        RouteHelper.routeHelper.pushNamed(
                          ProductDetailsScreen.routeName,
                        );
                      },
                      isFavorite: !homeProvider.favoriteProducts.any(
                          (element) =>
                              element.id ==
                              homeProvider.categoryProducts[index].id),
                      onFavoriteIconPressed: () {
                        homeProvider.deleteFromFavorite(
                          homeProvider.favoriteProducts[index].id,
                        );
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
