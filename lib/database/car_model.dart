import 'dart:collection';

import 'package:car/database/car_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'car.dart';

class CarModel extends ChangeNotifier {
  static final CarModel _instance = CarModel._privateConstructor();
  static final CarProvider _carProvider = CarProvider.instance;
  static List<Car>? _carListNullable;
  static List<Car> get _carList => _carListNullable!;

  CarModel._privateConstructor();

  static Future<CarModel> get instance async {
    _carListNullable ??= await _carProvider.readAll();
    return _instance;
  }

  UnmodifiableListView<Car> get carList => UnmodifiableListView(_carList);

  Future<void> createCar(Car car) async {
    car.id = await _carProvider.create(car);
    _carList.add(car);
    notifyListeners();
  }

  Future<void> updateCar(Car car) async {
    await _carProvider.update(car);
    var index = _carList.indexWhere((element) => element.id == car.id);
    _carList
      ..removeAt(index)
      ..insert(index, car);
    notifyListeners();
  }

  Future<void> deleteCar(int carId) async {
    await _carProvider.delete(carId);
    _carList.removeWhere((element) => element.id == carId);
    notifyListeners();
  }

  static CarModel fromContext(BuildContext context) {
    return Provider.of<CarModel>(context, listen: false);
  }
}
