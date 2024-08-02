import 'package:flutter/material.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/register/register_main.dart';
import 'package:frontend/screens/register/register_profile_alumni.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:frontend/utils.dart';
import 'package:get_it/get_it.dart';
import 'constants/colors.dart';


void main() async {
  await setup();
  runApp( MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerService();
}

class MyApp extends StatelessWidget {
  final GetIt getIt = GetIt.instance;
  late NavigationService navigationService;
  MyApp({super.key}) {
    navigationService = getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: "/home",
      routes: navigationService.routes,
      theme: lightMode,
      home: HomePage(),
    );
  }
  

}


