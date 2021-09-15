import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api/data/sp_helper.dart';
import 'package:store_api/helpers/route_helper.dart';
import 'package:store_api/providers/home_provider.dart';
import 'package:store_api/shared/widgets/global_widgets.dart';
import 'package:store_api/ui/screens/cart_screen.dart';
import 'package:store_api/ui/screens/favorite_products_screen.dart';
import 'package:store_api/ui/screens/product_details_screen.dart';
import 'package:store_api/ui/widgets/categories_list.dart';
import 'package:store_api/ui/widgets/product_item.dart';
import 'package:store_api/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(appName),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
            ),
            onPressed: () {
              RouteHelper.routeHelper
                  .pushNamed(FavoriteProductsScreen.routeName);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              RouteHelper.routeHelper.pushNamed(CartScreen.routeName);
              // Provider.of<HomeProvider>(context, listen: false)
              //     .login('moatasem.abunema@gmail.com', '12341234', 'fcmToken');
              // Provider.of<HomeProvider>(context, listen: false).register(
              //     'Angela',
              //     'Yu',
              //     'angela@gmail.com',
              //     '12341234',
              //     '+109866374',
              //     'fcmToken3');
            },
          ),
        ],
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                homeProvider.allProducts == null
                    ? Container(
                        color: Colors.white,
                        height: 300.0,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        color: Colors.white,
                        height: 300.0,
                        child: CarouselSlider(
                          items: homeProvider.allProducts.map((e) {
                            return CachedNetworkImage(
                              imageUrl: e.image,
                              fit: BoxFit.contain,
                            );
                          }).toList(),
                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.easeInOutBack,
                            height: 300,
                            aspectRatio: 16 / 9,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'All Categories',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 35.0,
                  child: homeProvider.allCategories == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : CategoriesList(),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  child: homeProvider.categoryProducts == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.only(
                              left: marginHorizontal,
                              right: marginHorizontal,
                              bottom: marginVertical,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 8,
                              // childAspectRatio: 7 / 8,
                            ),
                            itemCount: homeProvider.categoryProducts.length,
                            itemBuilder: (context, index) {
                              return ProductItem(
                                title:
                                    homeProvider.categoryProducts[index].title,
                                imageUrl:
                                    homeProvider.categoryProducts[index].image,
                                price:
                                    homeProvider.categoryProducts[index].price,
                                onTap: () {
                                  homeProvider.getSpecificProduct(
                                    homeProvider.categoryProducts[index].id,
                                  );
                                  RouteHelper.routeHelper.pushNamed(
                                    ProductDetailsScreen.routeName,
                                  );
                                },
                                isFavorite: homeProvider.favoriteProducts.any(
                                    (element) =>
                                        element.id ==
                                        homeProvider
                                            .categoryProducts[index].id),
                                onFavoriteIconPressed: () {
                                  homeProvider.addToFavorite(
                                    homeProvider.categoryProducts[index],
                                  );
                                  bool isFavorite = homeProvider
                                      .favoriteProducts
                                      .any((element) =>
                                          element.id ==
                                          homeProvider
                                              .categoryProducts[index].id);
                                  if (!isFavorite) {
                                    GlobalWidgets.globalWidgets.presentSnackBar(
                                      context: context,
                                      backgroundColor: Colors.green,
                                      duration: 1500,
                                      text: 'Item has been added to favorite',
                                    );
                                  }
                                  if (isFavorite) {
                                    GlobalWidgets.globalWidgets.presentSnackBar(
                                      context: context,
                                      backgroundColor: Colors.red,
                                      duration: 1500,
                                      text:
                                          'Item has been removed from favorite',
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
