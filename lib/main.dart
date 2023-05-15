import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_calc/data/expense_data.dart';
import 'package:money_calc/view/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  // Initialize hive
  await Hive.initFlutter();
  // Opening hive box
  await Hive.openBox('ExpenseDB');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      child: MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}


// continue to work 

//       https://www.youtube.com/watch?v=f7VewR__76I

// https://assets1.lottiefiles.com/packages/lf20_06a6pf9i.json