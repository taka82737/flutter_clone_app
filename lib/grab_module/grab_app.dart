import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'grab_main_screen.dart';
import 'login_screen.dart';
import 'providers/detail_screen_providers.dart';

class GrabApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarDetailProvider()),
        ChangeNotifierProvider(create: (_) => FoodDetailProvider()),
        ChangeNotifierProvider(create: (_) => ExpressDetailProvider()),
        ChangeNotifierProvider(create: (_) => WalletDetailProvider()),
        ChangeNotifierProvider(create: (_) => InsuranceDetailProvider()),
        ChangeNotifierProvider(create: (_) => GiftCardDetailProvider()),
      ],
      child: MaterialApp(
        title: 'Grab Clone',
        theme: ThemeData(primarySwatch: Colors.green),
        initialRoute: "/login",
        routes: {
          "/": (context) => GrabMainScreen(),
          "/login": (context) => GrabLoginScreen(),
        },
      ),
    );
  }
}
