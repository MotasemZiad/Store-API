import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api/providers/home_provider.dart';
import 'package:store_api/utils/constants.dart';

class CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: homeProvider.allCategories
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      homeProvider.getCategoryProducts(e);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(horizontal: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: homeProvider.selectedCategory == e
                            ? primaryColor
                            : Colors.white,
                      ),
                      child: Text(
                        e[0].toUpperCase() + e.substring(1),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: homeProvider.selectedCategory == e
                              ? Colors.white
                              : primaryColor,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
