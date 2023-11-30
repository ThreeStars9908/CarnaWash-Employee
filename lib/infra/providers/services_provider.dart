// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../ui/ui.dart';
import '../infra.dart';

class ServicesProvider with ChangeNotifier {
  final List<AdditionalModel> _additionalList = [];
  final List<CarsizeModel> _carSizeList = [];

  List<CarsizeModel> get carSizeList => _carSizeList;
  List<AdditionalModel> get additionalList => _additionalList;

  Future<void> loadAdditional(BuildContext context) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/services/additional/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );
      print('additional info' + response.body);
      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (Map i in v) {
          print('additional price' + i['price']);
          _additionalList.add(AdditionalModel(
            id: i['id'],
            title: i['title'],
            price: i['price'],
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
        'Provider Error! loadAdditionals',
        e.toString(),
      );
    }
  }

  Future<void> loadCarsize(BuildContext context) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/services/size/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (Map i in v) {
          _carSizeList.add(CarsizeModel(
            id: i['id'],
            title: i['title'],
            price: i['price'].toString(),
            additional_information: i['additional_information'],
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
        'Provider Error! loadCarsize',
        e.toString(),
      );
    }
  }

  AdditionalModel? getAdditionalComplete(int id) {
    print('additional id' + _additionalList.length.toString());
    return _additionalList.firstWhereOrNull((e) => e.id == id);
  }

  CarsizeModel getCarsizeComplete(int id) {
    return _carSizeList.where((e) => e.id == id).first;
  }
}
