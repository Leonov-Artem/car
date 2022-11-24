import 'package:car/database/car_columns.dart';

class Car {
  int? id;
  String model = 'Unknown model';
  String brand = 'Unknown brand';
  double price = 0.0;

  Car();

  Car.fromMap(Map<String, dynamic> map)
      : id = map[columnId],
        model = map[columnModel],
        brand = map[columnBrand],
        price = map[columnPrice];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnModel: model,
      columnBrand: brand,
      columnPrice: price,
    };
    if (id != null) map[columnId] = id;
    return map;
  }
}
