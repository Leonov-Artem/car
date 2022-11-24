import 'package:car/database/car.dart';
import 'package:car/database/car_model.dart';
import 'package:car/pages/car_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarListPage extends StatelessWidget {
  const CarListPage({Key? key}) : super(key: key);

  void _openCarDetailPage(BuildContext context, Car car) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CarDetailPage(selectedCar: car),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cars'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var newCar = Car();
          await CarModel.fromContext(context).createCar(newCar);
          _openCarDetailPage(context, newCar);
        },
      ),
      body: Consumer<CarModel>(
        builder: (context, carModel, child) {
          var carList = carModel.carList;
          return ListView.builder(
            itemCount: carList.length,
            itemBuilder: (context, itemIndex) {
              var car = carList[itemIndex];
              return Card(
                elevation: 8,
                child: ListTile(
                  title: Text('${car.model} (${car.brand})'),
                  subtitle: Text('\$${car.price}'),
                  onTap: () => _openCarDetailPage(context, car),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
