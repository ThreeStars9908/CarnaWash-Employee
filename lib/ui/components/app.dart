import 'package:app_employee/infra/providers/products_provider.dart';
import 'package:app_employee/infra/providers/training_module_provider.dart';
import 'package:app_employee/infra/providers/training_provider.dart';
import 'package:app_employee/ui/pages/pay_page.dart';
import 'package:app_employee/ui/pages/products_page.dart';
import 'package:app_employee/ui/pages/training_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../infra/infra.dart';
import '../ui.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConditionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PaymentProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScheduleProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WalletProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WasherProvider(),
        ),
        ChangeNotifierProvider<ServicesProvider>(
          create: (context) => ServicesProvider(),
        ),
        ChangeNotifierProvider<VehiclesProvider>(
          create: (context) => VehiclesProvider(),
        ),
        ChangeNotifierProvider<TrainingProvider>(
          create: (context) => TrainingProvider(),
        ),
        ChangeNotifierProvider<TrainingModuleProvider>(
          create: (context) => TrainingModuleProvider(),
        ),
        ChangeNotifierProvider<ProductsProvider>(
          create: (context) => ProductsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CarnaWash',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.HOME: (_) => const AuthOrHomeScreen(),
          AppRoutes.FIRST_LOGIN_HOME: (_) => FirstLoginHomePage(verify: 1),
          AppRoutes.LOGIN: (_) => const LoginPage(),
          AppRoutes.SCHEDULES: (_) => const SchedulesPage(),
          AppRoutes.SUPPLY: (_) => const SupplyPage(),
          AppRoutes.TRAINING: (_) => const TrainingPage(),
          AppRoutes.PRODUCTS: (_) => const ProductsPage(),
          AppRoutes.PAYMENTS: (_) => const PaymentsPage(),
          AppRoutes.HELP: (_) => const HelpPage(),
          AppRoutes.HELP_CHAT: (_) => const HelpChatPage(),
          AppRoutes.PERFIL: (_) => const PerfilPage(),
          AppRoutes.ACCOUNT: (_) => const AccountPage(),
          AppRoutes.WALLET: (_) => const WalletPage(),
          AppRoutes.LANGUAGE: (_) => const LanguagePage(),
          AppRoutes.NOTIFICATION_CONFIG: (_) => const NotificationConfigPage(),
          AppRoutes.NOTIFICATION: (_) => const NotificationPage(),
          AppRoutes.TERMS: (_) => const TermsConditionsPage(),
          AppRoutes.AVAILABILITY: (_) => const AvailabilityPage(),
          AppRoutes.WASH_REQUEST: (_) => WashRequestPage(),
          AppRoutes.PAY_REQUEST: (_) => PayPage(),
        },
      ),
    );
  }
}
