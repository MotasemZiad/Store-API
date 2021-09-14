import 'package:dio/dio.dart';
import 'package:store_api/utils/urls.dart';

class ApiHelper {
  ApiHelper._();
  static final apiHelper = ApiHelper._();

  final dio = Dio();

  Future<List<dynamic>> getAllCategories() async {
    const url = '$baseUrl/$productsNode/$categoriesNode';
    Response response = await dio.get(url);
    List<dynamic> categories = response.data;
    return categories;
  }

  Future<List<dynamic>> getCategoryProducts(String categoryName) async {
    final url = '$baseUrl/$productsNode/$categoryNode/$categoryName';
    Response response = await dio.get(url);
    List<dynamic> products = response.data;
    return products;
  }

  Future<List<dynamic>> getAllProducts() async {
    const url = '$baseUrl/$productsNode';
    Response response = await dio.get(url);
    List<dynamic> products = response.data;
    return products;
  }

  Future<dynamic> getSpecificProduct(int id) async {
    final url = '$baseUrl/$productsNode/$id';
    Response response = await dio.get(url);
    return response.data;
  }
}
