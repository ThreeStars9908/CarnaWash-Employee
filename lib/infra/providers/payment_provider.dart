// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../ui/ui.dart';
import '../infra.dart';

class PaymentProvider with ChangeNotifier {
  final List<PaymentModel> _listPayment = [];
  List<PaymentModel> get listPayment => _listPayment;
  late int _totalPrice = 0;
  int get totalPrice => _totalPrice;
  Future<void> loadHistory(
    BuildContext context,
    DateTime initialDate,
    DateTime endDate,
  ) async {
    UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      print('${Constants.BACKEND_BASE_URL}/payment/washer/pay-washer/$initialDate/$endDate/');
      final response = await http.get(
        Uri.parse(
            '${Constants.BACKEND_BASE_URL}/payment/washer/pay-washer/$initialDate/$endDate/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      var v = jsonDecode(response.body);
      var payment = v['payments'];
      var total = v['total_price'];
      _totalPrice = total;
      print('history' + response.body);
      if (response.statusCode == 200) {
        for (Map i in payment) {
          _listPayment.add(
            PaymentModel(
              id: i['id'],
              washer_id: i['washer_id'],
              wash_date: DateTime.parse(i['wash_date']),
              pay_data: DateTime.parse(i['pay_data']),
              wash_id: i['wash_id'],
            ),
          );
        }
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error! loadHistory',
        e.toString(),
      );
    }
  }

  Future<CarModel?> loadCar(BuildContext context, int id) async {
    UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/cars/washer/$id/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await loadCarSizes(context);
        CarModel(
          id: v['id'],
          brand: v['brand'],
          model: v['model'],
          plate: v['plate'],
          color: v['color'],
          car_size_id: v['car_size_id'],
        );
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error! loadCar',
        e.toString(),
      );
    }
    return null;
  }

  Future<List<CarsizeModel>?> loadCarSizes(BuildContext context) async {
    UserProvider userProvider = Provider.of(
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
        List list = [];
        for (Map i in v) {
          list.add(
            CarsizeModel(
              id: i['id'],
              title: i['title'],
              price: i['price'],
              additional_information: i['additional_information'],
            ),
          );
        }
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Erro!',
          v['errors'],
        );
      }
    } catch (e) {
      await comumDialog(
        context,
        'Provider Error! loadCarSizes',
        e.toString(),
      );
    }
    return null;
  }
}
