// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../ui/ui.dart';
import '../infra.dart';

class TrainingProvider with ChangeNotifier {
  final List<TrainingTypeModel> _trainingTypes = [];

  List<TrainingTypeModel> get trainingTypes => _trainingTypes;

  Future<void> loadTrainingTypes(BuildContext context) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {

      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/training/modules/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      dynamic v = jsonDecode(response.body);
      print('training types' + response.body);
      if (response.statusCode == 200) {
        _trainingTypes.clear();
        for (Map i in v) {
          _trainingTypes.add(TrainingTypeModel(
              id: i['id'],
              name: i['name'],
              progress: i['progress']));
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
        'Provider Error! GetNotifications',
        e.toString(),
      );
    }
  }
}
