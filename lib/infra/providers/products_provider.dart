// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:app_employee/data/models/products_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../ui/ui.dart';
import '../infra.dart';

class ProductsProvider with ChangeNotifier {
  final List<ProductsModel> _products = [];

  List<ProductsModel> get products => _products;

  Future<void> loadProducts(BuildContext context) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {

      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/products/all/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      dynamic v = jsonDecode(response.body);
      print('products' + response.body);
      if (response.statusCode == 200) {
        _products.clear();
        for (Map i in v) {
          _products.add(ProductsModel(
              id: i['id'],
              name: i['name'],
              price: i['price'],
              information: i['information'],
              photo: i['photo']));
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
        'Provider Error! getProducts',
        e.toString(),
      );
    }
  }
}
