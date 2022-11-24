import 'package:car/database/car_model.dart';
import 'package:car/pages/car_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var carModel = await CarModel.instance;

  runApp(
    ChangeNotifierProvider.value(
      value: carModel,
      child: const MaterialApp(
        home: CarListPage(),
        title: 'Localizations Sample App',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );
}
