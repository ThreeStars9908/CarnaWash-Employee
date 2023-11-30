// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data.dart';
import '../../ui/ui.dart';
import '../infra.dart';

class WalletProvider with ChangeNotifier {
  List<CardModel> _cards = [];

  List<CardModel> get cards => _cards;

  Future<void> loadCards(BuildContext context) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/payment/all/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (Map i in v) {
          _cards.add(
            CardModel(
              id: i['id'],
              name: i['name'],
              user_id: i['user_id'],
              last_digits: i['last_digits'],
              date: i['date'],
            ),
          );
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
        'Provider Error! Get Cards',
        e.toString(),
      );
    }
  }

  Future<void> createCard(
    BuildContext context,
    CardCreateUpdateModel card,
  ) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.post(
        Uri.parse('${Constants.BACKEND_BASE_URL}/payment/'),
        body: jsonEncode({
          'name': card.name,
          'card': card.card,
          'date': card.date,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Card created with success!'),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );

        await loadCards(context);

        Navigator.of(context).pop();
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
        'Provider Error! Create card',
        e.toString(),
      );
    }
  }

  Future<void> updateCard(
    BuildContext context,
    CardCreateUpdateModel card,
  ) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.post(
        Uri.parse('${Constants.BACKEND_BASE_URL}/payment/${card.id}'),
        body: jsonEncode({
          'name': card.name,
          'card': card.card,
          'date': card.date,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Card updated with success!'),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );

        await loadCards(context);

        Navigator.of(context).pop();
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
        'Provider Error! UpdateCard',
        e.toString(),
      );
    }
  }

  Future<void> deleteCard(
    BuildContext context,
    int id,
  ) async {
    final UserProvider userProvider = Provider.of(
      context,
      listen: false,
    );
    try {
      final response = await http.delete(
        Uri.parse('${Constants.BACKEND_BASE_URL}/payment/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userProvider.token}',
        },
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Card deleted with success!'),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );

        await loadCards(context);

        Navigator.of(context).pop();
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
        'Provider Error! Delete Card',
        e.toString(),
      );
    }
  }
}
