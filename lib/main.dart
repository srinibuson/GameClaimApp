import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:Claimit_app/Constant/allroute.dart';
import 'package:Claimit_app/Controller/dashboardcrtl.dart';
import 'package:Claimit_app/Controller/splashctrl.dart';
import 'package:Claimit_app/Controller/themectrl.dart';
import 'package:Claimit_app/Pages/Login/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashCtrl()),
        ChangeNotifierProvider(create: (_) => Dashboardcrtl()),
      ],
      child: ChangeNotifierProvider(
        create: (_) => Themectrl(),
        child: Consumer(
          builder: (context, themcon, widget) {
            return GetMaterialApp(
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    alwaysUse24HourFormat: false,
                    textScaler: TextScaler.linear(0.95),
                  ),
                  child: child!,
                );
              },
              debugShowCheckedModeBanner: false,
              // theme: themcon.themename,
              home: SplashScreen(),
              getPages: Routes.allRoute,
            );
          },
        ),
      ),
    );
  }
}
