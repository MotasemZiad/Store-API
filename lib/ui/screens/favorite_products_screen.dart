import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api/helpers/route_helper.dart';
import 'package:store_api/models/product.dart';
import 'package:store_api/providers/home_provider.dart';
import 'package:store_api/ui/screens/product_details_screen.dart';
import 'package:store_api/ui/widgets/product_item.dart';
import 'package:store_api/utils/constants.dart';

class FavoriteProductsScreen extends StatelessWidget {
  static const routeName = '/favorite';
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          List<ProductResponse> products = homeProvider.favoriteProducts;
          return products.length < 1
              ? Center(
                  child: Text(
                    'No favorite products has been added yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18.0,
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
                  itemCount: homeProvider.favoriteProducts.length,
                  itemBuilder: (context, index) {
                    return ProductItem(
                      title: homeProvider.favoriteProducts[index].title,
                      imageUrl: homeProvider.favoriteProducts[index].image,
                      price: homeProvider.favoriteProducts[index].price,
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
