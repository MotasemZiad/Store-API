import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api/providers/home_provider.dart';
import 'package:store_api/shared/widgets/custom_button.dart';
import 'package:store_api/shared/widgets/global_widgets.dart';
import 'package:store_api/utils/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product-details';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) => homeProvider
                    .selectedProduct ==
                null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: CachedNetworkImage(
                          imageUrl: homeProvider.selectedProduct.image,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: marginHorizontal,
                          vertical: marginVertical,
                        ),
                        child: Column(
                          children: [
                            Text(
                              homeProvider.selectedProduct.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              homeProvider.selectedProduct.description,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Price: ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  '\$${homeProvider.selectedProduct.price}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Row(
                              children: [
                                Text('Category: '),
                                Text(
                                    homeProvider.selectedProduct.category[0]
                                            .toUpperCase() +
                                        homeProvider.selectedProduct.category
                                            .substring(1),
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w900,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Row(
                              children: [
                                Text('Rating: '),
                                RatingBar.builder(
                                  itemSize: 25.0,
                                  initialRating:
                                      homeProvider.selectedProduct.rating.rate,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemPadding: EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: null,
                                  ignoreGestures: true,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Row(
                              children: [
                                Text('Count: '),
                                Text(
                                  homeProvider.selectedProduct.rating.count,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      CustomButton(
                        label: 'Add To Cart',
                        onPressed: () {
                          homeProvider.addToCart(homeProvider.selectedProduct);
                          GlobalWidgets.globalWidgets.presentSnackBar(
                            context: context,
                            text: 'Product added to cart successfully',
                            backgroundColor: Colors.green,
                            duration: 1500,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
