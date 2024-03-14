import 'package:flutter/material.dart';
import 'package:myapp/page-1/AuthenticationRoute.dart';
import 'package:myapp/page-1/GuardedRoute.dart';
import 'package:myapp/page-1/history.dart';
import 'package:myapp/page-1/login.dart';
import 'package:myapp/page-1/navbar.dart';
import 'package:myapp/page-1/home.dart';
import 'package:myapp/page-1/signup.dart';
import 'package:myapp/page-1/to-do-list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jfhbswvtjdkigvpntxrp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpmaGJzd3Z0amRraWd2cG50eHJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDk0ODUwNDYsImV4cCI6MjAyNTA2MTA0Nn0.yLLoLXzLVl08ev1k4qZwMqmys7-yGlo7dVnw7M9Mwwg',
  );

  runApp(DailyScheduleApp());
}

class DailyScheduleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Schedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LoginScreen(),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(settings: settings, builder: (context) => AuthenticationRoute(child: LoginScreen()));          
          case '/signup':
            return MaterialPageRoute(settings: settings, builder: (context) => AuthenticationRoute(child: SignupScreen()));          
          case '/home':
            return MaterialPageRoute(settings: settings, builder: (context) => const GuardedRoute(child: HomeScreen()));          
          case '/todo':
            return MaterialPageRoute(settings: settings, builder: (context) => GuardedRoute(child: ToDoListScreen()));          
          case '/history':
            return MaterialPageRoute(settings: settings, builder: (context) => GuardedRoute(child: HistoryScreen()));          
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
