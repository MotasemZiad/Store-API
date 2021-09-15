import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:store_api/data/sp_helper.dart';
import 'package:store_api/utils/urls.dart';

class ApiHelper {
  ApiHelper._();
  static final apiHelper = ApiHelper._();

  final dio = Dio();

  login(String email, String password, String fcmToken) async {
    String url = 'https://dashboard.giftyonline.ae/api/v1/login';
    Response response = await dio.post(url, data: {
      'email': email,
      'password': password,
      'fcm_token': fcmToken,
      'device_type': Platform.isAndroid
          ? 'android'
          : Platform.isIOS
              ? 'ios'
              : '',
    });
    SpHelper.spHelper.setToken(response.data['data']['access_token']);
  }

  register(
    String firstName,
    String lastName,
    String email,
    String password,
    String phone,
    String fcmToken,
  ) async {
    String url = 'https://dashboard.giftyonline.ae/api/v1/signup';
    Response response = await dio.post(url, data: {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'phone': phone,
      'fcm_token': fcmToken,
      'device_type': Platform.isAndroid
          ? 'android'
          : Platform.isIOS
              ? 'ios'
              : '',
    });
    print(response.data);
  }

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
