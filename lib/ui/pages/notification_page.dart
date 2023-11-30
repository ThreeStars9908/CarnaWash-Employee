// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../infra/infra.dart';
import '../ui.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      NotificationProvider notificationProvider = Provider.of(context, listen: false);

      await notificationProvider.loadGeralNotifications(context);
      await notificationProvider.loadNotifications(context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    NotificationProvider notificationProvider = Provider.of(context, listen: false);

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
                    children: [
                      backButtonComponent(context),
                      const Text(
                        'Notification',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: List.generate(
                      notificationProvider.notifications.length,
                      (index) => notificationBox(
                        context,
                        notificationProvider
                            .getNotificationID(
                                context,
                                notificationProvider
                                    .notifications[index].notification_id)!
                            .title,
                        notificationProvider
                            .getNotificationID(
                                context,
                                notificationProvider
                                    .notifications[index].notification_id)!
                            .type,
                        '1 hour ago',
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

  SizedBox notificationBox(
    BuildContext context,
    String text,
    int type,
    String time,
  ) {
    late IconData icon;
    if (type == 1) {
      icon = Icons.chat_bubble_outline;
    } else if (type == 2) {
      icon = Icons.check_circle_outline;
    } else if (type == 3) {
      icon = Icons.close;
    } else {
      icon = Icons.directions_car;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(
                  icon,
                  size: 30,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Text(
                      text,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Text(
                      time,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
