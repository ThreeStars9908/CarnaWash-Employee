import 'package:flutter/material.dart';

import '../../ui.dart';

Padding backButtonComponent(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: CircleAvatar(
      radius: 20,
      backgroundColor: const Color.fromRGBO(237, 189, 58, 1),
      child: IconButton(
        iconSize: 24,
        color: Colors.white,
        icon: const Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}

Widget notificationHomeButtonComponent(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: IconButton(
      iconSize: 40,
      icon: const Icon(
        Icons.notifications_outlined,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.NOTIFICATION);
      },
    ),
  );
}

IconButton notificationGeralButtonComponent(BuildContext context) {
  return IconButton(
    iconSize: 30,
    icon: const Icon(
      Icons.notifications_outlined,
    ),
    onPressed: () {
      Navigator.of(context).pushNamed(AppRoutes.NOTIFICATION);
    },
  );
}
