import 'package:iconify_flutter/icons/gis.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import '../../../infra/infra.dart';
import './pages.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider loginProvider = Provider.of(context, listen: false);

    return FutureBuilder(
      builder: (ctx, snapshot) {
        print('auth screen loaded' + snapshot.connectionState.toString());
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return const Center(child: Text('An Error has occured!'));
        } else {
          print(loginProvider.isAuth);
          return loginProvider.isAuth ? const HomePage() : const LoginPage();
        }
      },
      future: null,
    );
  }
}
