import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store_api/utils/constants.dart';

class ProductItem extends StatelessWidget {
  final Function onTap;
  final String imageUrl;
  final String title;
  final num price;
  final Function onFavoriteIconPressed;
  final bool isFavorite;
  ProductItem({
    @required this.title,
    @required this.imageUrl,
    @required this.price,
    @required this.onTap,
    @required this.onFavoriteIconPressed,
    this.isFavorite = false,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 0.0),
        height: 200.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 100.0,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Text(
                    'Error!',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Row(
              children: [
                Text('Price: '),
                Text(
                  '\$${price.toString()}',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                  onPressed: onFavoriteIconPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
