import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:practice_app/Constant/screens.dart';
import 'package:practice_app/Controller/splashctrl.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((T) {
      setState(() {
        context.read<SplashCtrl>().init();
      });
    });
  }

  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'Assets/loading.json',

              height: Screens.padingHeight(context) * 0.15,
            ),
          ),
          Text(
            'A GOOD GAMER NEVER MISSES FREE LOOT',
            style: theme.textTheme.bodyMedium!.copyWith(
              fontFamily: GoogleFonts.exo2().fontFamily,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
