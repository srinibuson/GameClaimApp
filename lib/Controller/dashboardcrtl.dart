import 'package:Claimit_app/Constant/constantroute.dart';
import 'package:Claimit_app/Constant/helper.dart';
import 'package:Claimit_app/Constant/screens.dart';
import 'package:Claimit_app/Pages/Dashboard/widget/favourite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:Claimit_app/Pages/Dashboard/widget/itempage.dart';
import 'package:Claimit_app/Pages/Dashboard/widget/profile.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboardcrtl extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  init() {
    selectedindex = 0;
  }

  int selectedindex = 0;
  List<Widget>? nav = [
    ItemsPage(),
    // Center(child: Text('Coming Soon', style: TextStyle(color: Colors.white))),
    FavouritesScreen(),
    ProfilePage(),
  ];

  bool liked = false;
  likedPress() {
    liked = !liked;
    notifyListeners();
  }

  alertdialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SizedBox(
            width: Screens.width(context) * 0.85,
            height: Screens.padingHeight(context) * 0.2,
            child: GlassContainer.clearGlass(
              padding: EdgeInsets.symmetric(
                vertical: Screens.padingHeight(context) * 0.03,
                horizontal: Screens.width(context) * 0.04,
              ),
              borderRadius: BorderRadius.circular(10),
              blur: 5,
              color: Colors.white.withOpacity(0.1),
              borderWidth: 0.5,
              elevation: 10,

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Are You Sure?",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: Screens.padingHeight(context) * 0.01),
                  Text(
                    textAlign: TextAlign.center,
                    "Do you want to Logout",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: Screens.padingHeight(context) * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: Screens.padingHeight(context) * 0.045,
                          width: Screens.width(context) * 0.32,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffDDE4EB)),
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xfff9f8f6),
                            // color: Color(0xff0A1D47)
                          ),
                          child: Center(
                            child: Text(
                              "Cancel",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Screens.width(context) * 0.02),
                      InkWell(
                        onTap: () async {
                          Get.back();
                          await FirebaseAuth.instance.signOut();
                          await HelperFunction.clearMailSP();
                          await HelperFunction.clearPasswordSP();
                          await HelperFunction.clearIsLoggedInSP();

                          notifyListeners();
                          Get.offAllNamed(ConstantRoute.loginpage);
                        },
                        child: Container(
                          height: Screens.padingHeight(context) * 0.045,
                          width: Screens.width(context) * 0.32,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Log Out",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
      },
    );
  }

  Future<void> openLink(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
