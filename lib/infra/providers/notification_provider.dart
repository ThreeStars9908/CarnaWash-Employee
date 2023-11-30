// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../ui/ui.dart';
import '../infra.dart';

class NotificationProvider with ChangeNotifier {
  final List<GeralNotificationModel> _geralNotifications = [];
  final List<UserNotificationModel> _notifications = [];

  List<GeralNotificationModel> get geralNotifications => _geralNotifications;
  List<UserNotificationModel> get notifications => _notifications;

  Future<void> loadNotifications(BuildContext context) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {

      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/notification/sent/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );


      dynamic v = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('notify' + response.body);
        _notifications.clear();
        for (Map i in v) {
          _notifications.add(UserNotificationModel(
              notification_id: i['notification_id'],
              user_type_id: i['user_type_id'],
              user_id: i['user_id']));
        }
        await loadGeralNotifications(context);
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

  Future<void> loadGeralNotifications(BuildContext context) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/notification/user/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (Map i in v) {
          _geralNotifications.add(GeralNotificationModel(
              id: i['id'],
              title: i['title'],
              destined_to: i['destined_to'],
              type: i['type']));
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

  GeralNotificationModel? getNotificationID(BuildContext context, int id) {
    for (GeralNotificationModel element in _geralNotifications) {
      if (element.id == id) {
        return element;
      }
    }

    return null;
  }
}
