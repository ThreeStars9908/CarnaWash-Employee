// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../ui/ui.dart';
import '../infra.dart';

class VehiclesProvider with ChangeNotifier {
  List<CarModel> _carsList = [];
  List<CarModel> get carsList => _carsList;

  Future<void> loadCars(BuildContext context) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/cars/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );
      print('cars--' + response.body);
      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (Map i in v) {
          _carsList.add(CarModel(
            id: i['id'],
            brand: i['brand'],
            model: i['model'],
            plate: i['plate'],
            color: i['color'],
            car_size_id: i['car_size_id'],
          ));
        }
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Error',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error! SubmitCreate',
        e.toString(),
      );
    }
  }

  CarModel? loadOneCar(
    BuildContext context,
    int id,
  ) {
    for (CarModel element in _carsList) {
      if (element.id == id) {
        return element;
      }
    }

    return null;
  }
}
