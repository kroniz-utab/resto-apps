import 'package:restaurant_apps/model/restaurant_list_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorite = 'favorite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/resto.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tblFavorite (
            id VARCHAR PRIMARY KEY,
            name VARCHAR,
            description TEXT,
            pictureId VARCHAR,
            city VARCHAR,
            rating DOUBLE
          )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  /// create favorite pipelines
  Future<void> insertFavoriteResto(Restaurant resto) async {
    final db = await database;
    await db!.insert(_tblFavorite, resto.toJson());
  }

  /// get all favorite restaurant
  Future<List<Restaurant>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((e) => Restaurant.fromJson(e)).toList();
  }

  /// get favorite restaurant by id
  Future<Map> getFavoriteRestoById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  /// delete favorite restaurant by id
  Future<void> unfavoritedRestaurant(String id) async {
    final db = await database;

    await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
