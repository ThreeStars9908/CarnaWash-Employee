import 'package:flutter/material.dart';

import '../ui.dart';

class NotificationConfigPage extends StatefulWidget {
  const NotificationConfigPage({super.key});

  @override
  State<NotificationConfigPage> createState() => _NotificationConfigPageState();
}

class _NotificationConfigPageState extends State<NotificationConfigPage> {
  bool enable = true;
  @override
  Widget build(BuildContext context) {
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
                            'Notification Settings',
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
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Switch(
                        value: enable,
                        activeColor: const Color.fromRGBO(237, 189, 58, 1),
                        onChanged: (bool value) {
                          setState(() {
                            enable = value;
                          });
                        },
                      ),
                      const Text(
                        'Push Notifications',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
