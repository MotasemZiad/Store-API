import 'package:flutter/cupertino.dart';
import 'package:store_api/data/api_helper.dart';
import 'package:store_api/data/db_helper.dart';
import 'package:store_api/models/product.dart';

class HomeProvider extends ChangeNotifier {
  List<ProductResponse> allProducts = [];
  List<ProductResponse> categoryProducts = [];
  List<String> allCategories = [];
  ProductResponse selectedProduct;
  String selectedCategory = '';

  List<ProductResponse> cartProducts = [];
  List<ProductResponse> favoriteProducts = [];

  getAllProducts() async {
    List<dynamic> products = await ApiHelper.apiHelper.getAllProducts();
    allProducts = products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
  }

  getCategoryProducts(String categoryName) async {
    categoryProducts = null;
    selectedCategory = categoryName;
    notifyListeners();
    List<dynamic> products =
        await ApiHelper.apiHelper.getCategoryProducts(categoryName);
    categoryProducts =
        products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
  }

  getAllCategories() async {
    List<dynamic> categories = await ApiHelper.apiHelper.getAllCategories();
    allCategories = categories.map((e) => e.toString()).toList();
    getCategoryProducts(allCategories.first);
    notifyListeners();
  }

  getSpecificProduct(int id) async {
    selectedProduct = null;
    notifyListeners();
    dynamic json = await ApiHelper.apiHelper.getSpecificProduct(id);
    selectedProduct = ProductResponse.fromJson(json);
    notifyListeners();
  }

  // Cart
  getAllCartProducts() async {
    List<ProductResponse> products =
        await DbHelper.dbHelper.getAllCartProducts();
    cartProducts = products;
    notifyListeners();
  }

  addToCart(ProductResponse productResponse) async {
    bool productInCart =
        favoriteProducts.any((element) => element.id == productResponse.id);
    if (productInCart) {
      await DbHelper.dbHelper.deleteProductFromCart(productResponse.id);
    } else {
      await DbHelper.dbHelper.addProductToCart(productResponse);
    }
    getAllCartProducts();
    notifyListeners();
  }

  deleteFromCart(int id) async {
    await DbHelper.dbHelper.deleteProductFromCart(id);
    getAllCartProducts();
    notifyListeners();
  }

  // Favorite
  getAllFavoriteProducts() async {
    List<ProductResponse> products =
        await DbHelper.dbHelper.getAllFavoriteProducts();
    favoriteProducts = products;
    notifyListeners();
  }

  addToFavorite(ProductResponse productResponse) async {
    bool isFavorite =
        favoriteProducts.any((element) => element.id == productResponse.id);
    if (isFavorite) {
      deleteFromFavorite(productResponse.id);
    } else {
      await DbHelper.dbHelper.addProductToFavorite(productResponse);
    }
    getAllFavoriteProducts();
    notifyListeners();
  }

  deleteFromFavorite(int id) async {
    await DbHelper.dbHelper.deleteProductFromFavorite(id);
    getAllFavoriteProducts();
    notifyListeners();
  }
}
