// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../data/data.dart';
import '../../ui/ui.dart';
import '../infra.dart';

class UserProvider with ChangeNotifier {
  String _token = '';
  late UserCompleteModel _perfil;

  String get token => _token;
  UserCompleteModel get perfil => _perfil;

  bool get isAuth {
    return _token != '';
  }

  Future<void> submitLogin(
      BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.BACKEND_BASE_URL}/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      var v = jsonDecode(response.body);
      if (response.statusCode == 200) {
        _token = v['token'];
        print(_token);
        await loadPerfil(context);
        Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);

      } else {
        await comumDialog(
          context,
          'Error',
          v['errors'],
        );
      }

      // Navigator.of(context).pushNamed(AppRoutes.HOME);


    } catch (e) {
      await comumDialog(
        context,
        'Provider Error! SubmitLogin',
        e.toString(),
      );
    }
  }

  Future<void> signIn(
    BuildContext context,
    UserSignModel user,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.BACKEND_BASE_URL}/users/'),
        body: jsonEncode({
          "email": user.email,
          "password": user.password,
          "name": user.name,
          "phone": user.phone,
          "address": user.address,
        }),
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _token = v[1];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Account Created! Verify your email!'),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );
        Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
      } else if (v['errors'] != '') {
        await comumDialog(
          context,
          'Error',
          v['errors'],
        );
      }

      Navigator.of(context).pushNamed(AppRoutes.HOME);

    } catch (e) {
      await comumDialog(
        context,
        'Provider Error! SignIn',
        e.toString(),
      );
    }
  }

  Future<void> loadPerfil(BuildContext context) async {
    try {
      print('loadperfil');
      final response = await http.get(
        Uri.parse('${Constants.BACKEND_BASE_URL}/user/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        print("res" + response.body);
        dynamic userData = json.decode(response.body);
        UserCompleteModel userDataModel = UserCompleteModel(name: userData['name'], email: userData['email'],
            phone: userData['phone'], address: userData['address']);
        _perfil = userDataModel;
        print("ssssssss");
      } else if (jsonDecode(response.body)['errors'] != '') {
        await comumDialog(
          context,
          'Error!',
          jsonDecode(response.body)['errors'],
        );
      }
    } catch (e) {
      print(e);
      await comumDialog(
        context,
        'Provider Error!',
        'An error occurred while trying to get the profile values. $e',
      );
    }
  }

  Future<void> updatePerfil(
      BuildContext context, UserCompleteModel newUser) async {
    print('sssssss________');
    try {
      final response = await http.put(
        Uri.parse('${Constants.BACKEND_BASE_URL}/users/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({
          "name": newUser.name,
          "email": newUser.email,
          "phone": newUser.phone,
          "address": newUser.address,
        }),
      );

      var v = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await comumDialog(
          context,
          'Usuário Atualizado',
          'Usuário atualizado com Sucesso!',
        );
        await loadPerfil(context);
        Navigator.of(context).pop();

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
        'Provider Error!',
        e.toString(),
      );
    }
  }

  void logout() {
    _token = '';

  }
}
