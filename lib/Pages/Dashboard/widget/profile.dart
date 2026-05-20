import 'package:Claimit_app/Constant/constantvalue.dart';
import 'package:Claimit_app/Controller/dashboardcrtl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Claimit_app/Constant/screens.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  Image.asset('Assets/profile.png', scale: 1.5),
                  SizedBox(width: Screens.width(context) * 0.02),
                  SizedBox(
                    width: Screens.width(context) * 0.7,
                    child: Text(
                      ConstantValues.usermail!,
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
              InkWell(
                onTap: () {
                  context.read<Dashboardcrtl>().openLink(
                    "https://github.com/srinibuson/GameClaimApp/releases",
                  );
                },
                child: Row(
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
              SizedBox(height: Screens.padingHeight(context) * 0.03),
              InkWell(
                onTap: () {
                  context.read<Dashboardcrtl>().alertdialog(context);
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'Assets/logout.png',
                        color: Colors.white,
                        scale: 1.5,
                      ),
                    ),
                    SizedBox(width: Screens.width(context) * 0.02),
                    SizedBox(
                      width: Screens.width(context) * 0.7,

                      child: Text(
                        'Log Out',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.redAccent,
                          fontFamily: GoogleFonts.exo2().fontFamily,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
