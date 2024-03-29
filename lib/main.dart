import 'package:finance_tracker/providers/finance_provider.dart';
import 'package:finance_tracker/providers/finance_update_provider.dart';
import 'package:finance_tracker/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCPcPj6WiehZCRtlPe_leOpQwGQhrRpl3I",
      appId: "1:713161476028:android:64356d89957faf27214db9",
      messagingSenderId: "Your messaging sender ID",
      projectId: "Your project ID",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FinanceProvider()),
        ChangeNotifierProvider(create: (context) => FinanceUpdateProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Finance Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
