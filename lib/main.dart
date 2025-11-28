import 'package:flutter/material.dart';
import 'package:realtodo/app/app.bottomsheets.dart';
import 'package:realtodo/app/app.dialogs.dart';
import 'package:realtodo/app/app.locator.dart';
import 'package:realtodo/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://bthrfljhipdjyezmqwhl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ0aHJmbGpoaXBkanllem1xd2hsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQyMzI4NjcsImV4cCI6MjA3OTgwODg2N30.VCo6BE7DOH1lMR5UROU6hwjqhTa91xjGty8NXTdqog8',
  );
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
    );
  }
}
