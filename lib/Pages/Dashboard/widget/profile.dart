import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:practice_app/Constant/screens.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Screens.width(context) * 0.04,
          ),
          child: Column(
            children: [
              SizedBox(height: Screens.padingHeight(context) * 0.03),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GlassContainer.clearGlass(
                      height: Screens.padingHeight(context) * 0.07,
                      width: Screens.width(context) * 0.15,
                      borderRadius: BorderRadius.circular(10),
                      blur: 5,
                      color: Colors.white.withOpacity(0.1),
                      borderWidth: 0.5,
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: Screens.padingHeight(context) * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Lottie.asset('Assets/user.json'),
                      ),
                    ),
                  ),

                  SizedBox(width: Screens.width(context) * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Srinivas',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontFamily: GoogleFonts.exo2().fontFamily,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        'Indie Flutter Developer',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontFamily: GoogleFonts.exo2().fontFamily,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: Screens.padingHeight(context) * 0.03),
              Row(
                children: [
                  Image.asset('Assets/git.png', scale: 1.5),
                  SizedBox(width: Screens.width(context) * 0.02),
                  SizedBox(
                    width: Screens.width(context) * 0.7,
                    child: Text(
                      'View In GitHub',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontFamily: GoogleFonts.exo2().fontFamily,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Screens.padingHeight(context) * 0.03),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'Assets/cup2.png',
                      color: Colors.white,
                      scale: 1.5,
                    ),
                  ),
                  SizedBox(width: Screens.width(context) * 0.02),
                  SizedBox(
                    width: Screens.width(context) * 0.7,

                    child: Text(
                      'Buy Me A Coffee',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontFamily: GoogleFonts.exo2().fontFamily,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
