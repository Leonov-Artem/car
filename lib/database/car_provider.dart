import 'package:car/database/car_columns.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'car.dart';

const _tableName = 'cars';
const _fileName = '$_tableName.db';

class CarProvider {
  static final CarProvider _instance = CarProvider._privateConstructor();
  Database? _db;

  Future<Database> get _database async {
    _db ??= await _openDatabase(_fileName);
    return _db!;
  }

  CarProvider._privateConstructor();

  Future<Database> _openDatabase(String databaseFileName) async {
    return openDatabase(join(await getDatabasesPath(), databaseFileName),
        version: 1, onCreate: (database, version) {
      database.execute('''
          create table if not exists $_tableName (
          $columnId integer primary key,
          $columnModel text,
          $columnBrand text,
          $columnPrice real
          )
          ''');
    });
  }

  static CarProvider get instance => _instance;

  Future<int> create(Car car) async {
    var database = await _database;
    return database.insert(_tableName, car.toMap());
  }

  Future<Car> read(int carId) async {
    var database = await _database;
    var mapList = await database.query(
      _tableName,
      where: '$columnId = ?',
      whereArgs: [carId],
    );
    return Car.fromMap(mapList.first);
  }

  Future<List<Car>> readAll() async {
    var database = await _database;
    var mapList = await database.query(_tableName);
    return mapList.isNotEmpty
        ? mapList.map((e) => Car.fromMap(e)).toList()
        : [];
  }

  Future<int> update(Car car) async {
    var database = await _database;
    return database.update(
      _tableName,
      car.toMap(),
      where: '$columnId = ?',
      whereArgs: [car.id],
    );
  }

  Future<int> delete(int carId) async {
    var database = await _database;
    return database.delete(
      _tableName,
      where: '$columnId = ?',
      whereArgs: [carId],
    );
  }
}
