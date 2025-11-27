import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/core/initial_binding.dart';
import 'package:weather_app/app/routes/app_pages.dart';
import 'package:weather_app/app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print("-------Main Started----------");

  await dotenv.load(fileName:'.env');
  print("DOTENV LOADED");
  print("ENV CONTENT: ${dotenv.env}");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialBinding: InitialBinding(),
      initialRoute: AppPages.SPLASH,
      defaultTransition: Transition.fadeIn,
      getPages: AppRoutes.routes,
    );
  }
}
