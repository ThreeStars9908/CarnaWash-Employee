import 'package:flutter/material.dart';

import '../../ui.dart';

Widget navigationBarComponent(BuildContext context) {
  return SizedBox(
    height: 70,
    child: BottomNavigationBar(
      selectedLabelStyle: const TextStyle(
        color: Colors.blue,
        fontSize: 14,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
      selectedIconTheme: const IconThemeData(
        color: Colors.blue,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushNamed(AppRoutes.HOME);
            break;
          case 1:
            Navigator.of(context).pushNamed(AppRoutes.SCHEDULES);
            break;
          case 2:
            Navigator.of(context).pushNamed(AppRoutes.PAYMENTS);
            break;
          case 3:
            Navigator.of(context).pushNamed(AppRoutes.HELP);
            break;
          case 4:
            Navigator.of(context).pushNamed(AppRoutes.PERFIL);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color: Colors.grey,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_month_outlined,
            color: Colors.grey,
          ),
          label: 'Schedules',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.attach_money,
            color: Colors.grey,
          ),
          label: 'Payments',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.help_outline,
            color: Colors.grey,
          ),
          label: 'Help',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: Colors.grey,
          ),
          label: 'Profile',
        ),
      ],
    ),
  );
}
