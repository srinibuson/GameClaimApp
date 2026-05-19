import 'package:flutter/material.dart';

import 'package:glass_kit/glass_kit.dart';

import 'package:Claimit_app/Constant/screens.dart';
import 'package:Claimit_app/Controller/dashboardcrtl.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<Dashboardcrtl>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(child: controller.nav![controller.selectedindex]),

            Positioned(
              bottom: 0,
              child: Container(
                width: Screens.width(context),
                padding: EdgeInsets.symmetric(
                  horizontal: Screens.width(context) * 0.05,
                  vertical: Screens.padingHeight(context) * 0.01,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GlassContainer.clearGlass(
                    height: Screens.padingHeight(context) * 0.06,
                    // width: 260,
                    borderRadius: BorderRadius.circular(10),
                    blur: 5,
                    color: Colors.white.withOpacity(0.1),
                    borderWidth: 0.5,
                    elevation: 10,
                    // filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Screens.width(context) * 0.05,
                        vertical: Screens.padingHeight(context) * 0.015,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.08),

                        border: Border.all(
                          color: Colors.white.withOpacity(0.25),
                          width: 1.2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 30,
                            offset: Offset(0, 12),
                            spreadRadius: -10,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                controller.selectedindex = 0;
                              });
                            },
                            child: Image.asset(
                              'Assets/home.png',
                              color:
                                  controller.selectedindex == 0
                                      ? Colors.blueAccent
                                      : Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                controller.selectedindex = 1;
                              });
                            },
                            child: Image.asset(
                              'Assets/favorite.png',
                              color:
                                  controller.selectedindex == 1
                                      ? Colors.blueAccent
                                      : Colors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                controller.selectedindex = 2;
                              });
                            },
                            child: Image.asset(
                              // scale: 0.5,
                              'Assets/profile3.png',
                              color:
                                  controller.selectedindex == 2
                                      ? Colors.blueAccent
                                      : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // body: controller.nav![controller.selectedindex],
      ),
    );
  }
}
