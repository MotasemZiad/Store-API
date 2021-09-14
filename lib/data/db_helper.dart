import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:store_api/models/product.dart';

class DbHelper {
  DbHelper._();
  static final dbHelper = DbHelper._();
  Database database;

  final dbName = 'ecommerce.db';
  final dbVersion = 1;
  // Cart Table
  final cartTableName = 'Cart';
  final idCartColumnName = 'id';
  final titleCartColumnName = 'title';
  final priceCartColumnName = 'price';
  final descriptionCartColumnName = 'description';
  final categoryCartColumnName = 'category';
  final imageCartColumnName = 'image';
  final rateCartColumnName = 'rate';
  final countCartColumnName = 'count';
  final quantityCartColumnName = 'quantity';
  // Favorite Table
  final favoriteTableName = 'Favorite';

  initDatabase() async {
    if (database != null) return;
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    Database database = await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $cartTableName (
          $idCartColumnName INTEGER PRIMARY KEY,
          $titleCartColumnName TEXT,
          $priceCartColumnName REAL,
          $descriptionCartColumnName TEXT,
          $categoryCartColumnName TEXT,
          $imageCartColumnName TEXT,
          $rateCartColumnName REAL, 
          $countCartColumnName INTEGER,
          $quantityCartColumnName INTEGER
          );
        ''');
        db.execute('''
        CREATE TABLE $favoriteTableName (
          $idCartColumnName INTEGER PRIMARY KEY,
          $titleCartColumnName TEXT,
          $priceCartColumnName REAL,
          $descriptionCartColumnName TEXT,
          $categoryCartColumnName TEXT,
          $imageCartColumnName TEXT,
          $rateCartColumnName REAL, 
          $countCartColumnName TEXT,
          $quantityCartColumnName INTEGER
          );
        ''');
      },
      onOpen: (db) {
        print('Database has been opened');
      },
    );
    return database;
  }

  // Cart Methods
  addProductToCart(ProductResponse productResponse) async {
    try {
      int row =
          await database.insert(cartTableName, productResponse.toDbJson());
      print(row);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<ProductResponse>> getAllCartProducts() async {
    List<Map<String, Object>> result = await database.query(cartTableName);
    return result.map((e) => ProductResponse.fromJson(e)).toList();
  }

  deleteProductFromCart(int id) async {
    try {
      int row = await database.delete(cartTableName,
          where: '$idCartColumnName =?', whereArgs: [id]);
      print(row);
    } on Exception catch (e) {
      print(e);
    }
  }

  // Favorite Methods
  Future<bool> addProductToFavorite(ProductResponse productResponse) async {
    try {
      int row =
          await database.insert(favoriteTableName, productResponse.toDbJson());
      print(row);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<ProductResponse>> getAllFavoriteProducts() async {
    List<Map<String, Object>> result = await database.query(favoriteTableName);
    return result.map((e) => ProductResponse.fromJson(e)).toList();
  }

  Future<bool> deleteProductFromFavorite(int id) async {
    try {
      int row = await database
          .delete(favoriteTableName, where: 'id =?', whereArgs: [id]);
      print(row);
      return false;
    } on Exception catch (e) {
      print(e);
      return true;
    }
  }
}
