import 'package:car/database/car.dart';
import 'package:car/database/car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CarDetailPage extends StatefulWidget {
  final Car selectedCar;

  const CarDetailPage({Key? key, required this.selectedCar}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  late Car _car;
  late TextEditingController _modelEditingController;
  late TextEditingController _brandEditingController;
  late TextEditingController _priceEditingController;

  @override
  void initState() {
    super.initState();

    _car = widget.selectedCar;
    _modelEditingController = TextEditingController(text: _car.model);
    _modelEditingController.addListener(() {
      _car.model = _modelEditingController.text;
    });

    _brandEditingController = TextEditingController(text: _car.brand);
    _brandEditingController.addListener(() {
      _car.brand = _brandEditingController.text;
    });

    _priceEditingController =
        TextEditingController(text: _car.price.toString());
    _priceEditingController.addListener(() {
      _car.price = double.parse(_priceEditingController.text);
    });
  }

  void _saveCarChanges(BuildContext context) {
    CarModel.fromContext(context).updateCar(_car);
  }

  void _deleteCar(BuildContext context) {
    CarModel.fromContext(context).deleteCar(_car.id!);
  }

  AppLocalizations get _string => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _saveCarChanges(context);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _saveCarChanges(context);
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Text(_string.enterCarModelLeadingText),
              title: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: _string.carModelHintText),
                controller: _modelEditingController,
              ),
            ),
            ListTile(
              leading: Text(_string.enterCarBrandLeadingText),
              title: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: _string.carBrandHintText),
                controller: _brandEditingController,
              ),
            ),
            ListTile(
              leading: Text(_string.enterCarPriceLeadingText),
              title: TextFormField(
                keyboardType: TextInputType.number,
                controller: _priceEditingController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: ElevatedButton(
                child: Text(_string.deleteButtonText),
                onPressed: () {
                  _deleteCar(context);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
