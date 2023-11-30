import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../infra/infra.dart';
import '../ui.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context, listen: false);

    return Scaffold(
      bottomNavigationBar: navigationBarComponent(context),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          backButtonComponent(context),
                          const Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      notificationGeralButtonComponent(context),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Divider(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProvider.perfil.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          userProvider.perfil.email,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 25),
                  profileButton(
                    context,
                    'My account Information',
                    Icons.person,
                    AppRoutes.ACCOUNT,
                  ),
                  profileButton(
                    context,
                    'My Supppliers',
                    Icons.book_outlined,
                    AppRoutes.SUPPLY,
                  ),
                  profileButton(
                    context,
                    'Availability',
                    Icons.timer_outlined,
                    AppRoutes.AVAILABILITY,
                  ),
                  profileButton(
                    context,
                    'Training area',
                    FontAwesomeIcons.award,
                    AppRoutes.TRAINING,
                  ),
                  profileButton(
                    context,
                    'Products',
                    Icons.shopping_cart,
                    AppRoutes.PRODUCTS,
                  ),
                  profileButton(
                    context,
                    'Wallet',
                    Icons.credit_card,
                    AppRoutes.WALLET,
                  ),
                  profileButton(
                    context,
                    'Language',
                    Icons.more_horiz_outlined,
                    AppRoutes.LANGUAGE,
                  ),
                  profileButton(
                    context,
                    'Notification Settings',
                    Icons.notifications_outlined,
                    AppRoutes.NOTIFICATION_CONFIG,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.TERMS);
                      },
                      child: const Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          color: Color.fromRGBO(237, 189, 58, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.LOGIN);
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Color.fromRGBO(237, 189, 58, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox profileButton(
    BuildContext context,
    String text,
    IconData icon,
    String route,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 50),
                ),
                iconColor: MaterialStateProperty.all(Colors.black)),
            onPressed: () {
              Navigator.of(context).pushNamed(route);
            },
            icon: Icon(icon),
            label: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
