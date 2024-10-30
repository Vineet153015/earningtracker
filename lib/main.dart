import 'package:earningtracker/screens/earningScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/earningprovider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EarningsProvider()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EarningsProvider(),
          child: MyApp(),
        )
      ],
      child: MaterialApp(
        title: 'Earnings Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: EarningsScreen(),
      ),
    );
  }
}
