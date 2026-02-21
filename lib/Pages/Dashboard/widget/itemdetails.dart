import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:practice_app/Constant/screens.dart';
import 'package:practice_app/Controller/dashboardcrtl.dart';
import 'package:practice_app/Controller/splashctrl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({super.key});
  static int? index;
  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final list = context.watch<SplashCtrl>().itemlist[ItemDetailsPage.index!];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        title: SizedBox(
          // color: Colors.red,
          height: Screens.padingHeight(context) * 0.025,
          child: Marquee(
            text: list.title,

            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 20.0,
            velocity: 100.0,
            pauseAfterRound: Duration(seconds: 1),
            startPadding: 10.0,
            accelerationDuration: Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Screens.width(context) * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Screens.padingHeight(context) * 0.25,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(list.image, fit: BoxFit.cover),
                  ),
                ),

                SizedBox(height: Screens.padingHeight(context) * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Screens.width(context) * 0.75,
                      height: Screens.padingHeight(context) * 0.05,

                      child: GestureDetector(
                        onTap: () {
                          log('Claimable');
                          context.read<Dashboardcrtl>().openLink(
                            list.openGiveawayUrl,
                          );
                        },

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),

                          child: GlassContainer.clearGlass(
                            height: Screens.padingHeight(context) * 0.06,

                            borderRadius: BorderRadius.circular(10),
                            blur: 5,
                            color: Colors.white.withOpacity(0.1),
                            borderWidth: 0.5,
                            elevation: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Claim',
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.exo2().fontFamily,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        context.read<Dashboardcrtl>().likedPress();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.05,
                        ),
                        child: Icon(
                          context.watch<Dashboardcrtl>().liked == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              context.watch<Dashboardcrtl>().liked == true
                                  ? Colors.pinkAccent
                                  : Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Screens.padingHeight(context) * 0.02),

                ConstrainedBox(
                  // color: Colors.amberAccent,
                  constraints: BoxConstraints(
                    maxHeight: Screens.padingHeight(context) * 0.15,
                  ),

                  child: Text(
                    list.description,
                    textAlign: TextAlign.justify,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: GoogleFonts.exo2().fontFamily,
                    ),
                  ),
                ),
                SizedBox(height: Screens.padingHeight(context) * 0.01),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        'Platforms :',

                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: GoogleFonts.exo2().fontFamily,
                        ),
                      ),
                    ),
                    SizedBox(height: Screens.padingHeight(context) * 0.005),
                    SizedBox(
                      // color: Colors.red,
                      width: Screens.width(context) * 0.9,
                      child: Text(
                        '    ${list.platforms}',

                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: GoogleFonts.exo2().fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Screens.padingHeight(context) * 0.01),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        'Expiry On :',

                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: GoogleFonts.exo2().fontFamily,
                        ),
                      ),
                    ),
                    SizedBox(height: Screens.padingHeight(context) * 0.005),
                    SizedBox(
                      // color: Colors.red,
                      width: Screens.width(context) * 0.9,
                      child: Text(
                        list.endDate.toLowerCase() == 'n/a'
                            ? '    Soon'
                            : '    ${list.endDate}',

                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: GoogleFonts.exo2().fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Screens.padingHeight(context) * 0.01),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        'Type :',

                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: GoogleFonts.exo2().fontFamily,
                        ),
                      ),
                    ),
                    SizedBox(height: Screens.padingHeight(context) * 0.005),
                    Row(
                      children: [
                        SizedBox(width: Screens.width(context) * 0.03),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Screens.width(context) * 0.03,
                            vertical: Screens.padingHeight(context) * 0.005,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            list.type,

                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: GoogleFonts.exo2().fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: Screens.padingHeight(context) * 0.01),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        'Price :',

                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: GoogleFonts.exo2().fontFamily,
                        ),
                      ),
                    ),
                    SizedBox(height: Screens.padingHeight(context) * 0.005),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '    ',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: GoogleFonts.exo2().fontFamily,
                            ),
                          ),
                          TextSpan(
                            text: list.worth,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: GoogleFonts.exo2().fontFamily,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 2,
                              decorationColor: Colors.white70,
                            ),
                          ),
                          TextSpan(
                            text: ' - Free',
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: GoogleFonts.exo2().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Screens.padingHeight(context) * 0.01),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        'Details :',

                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.5),
                          fontFamily: GoogleFonts.exo2().fontFamily,
                        ),
                      ),
                    ),
                    SizedBox(height: Screens.padingHeight(context) * 0.005),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              // color: Colors.red,
                              width: Screens.width(context) * 0.3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '    Status',

                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: GoogleFonts.exo2().fontFamily,
                                    ),
                                  ),
                                  Text(
                                    ' - ',

                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: GoogleFonts.exo2().fontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.005,
                            ),
                            SizedBox(
                              // color: Colors.red,
                              width: Screens.width(context) * 0.3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '    Users Claimed',

                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: GoogleFonts.exo2().fontFamily,
                                    ),
                                  ),
                                  Text(
                                    ' - ',

                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.5),
                                      fontFamily: GoogleFonts.exo2().fontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              ' ${list.status}',

                              style: theme.textTheme.bodyMedium!.copyWith(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.exo2().fontFamily,
                              ),
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.005,
                            ),
                            Text(
                              ' ${list.users}',

                              style: theme.textTheme.bodyMedium!.copyWith(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: GoogleFonts.exo2().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
