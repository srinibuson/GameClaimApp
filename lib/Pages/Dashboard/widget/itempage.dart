import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_app/Constant/constantroute.dart';
import 'package:practice_app/Constant/screens.dart';

import 'package:practice_app/Controller/splashctrl.dart';
import 'package:practice_app/Pages/Dashboard/widget/itemdetails.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((T) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SplashCtrl>();
    final theme = Theme.of(context);

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          // top: Screens.padingHeight(context) * 0.01,
          left: Screens.width(context) * 0.03,
          right: Screens.width(context) * 0.03,
        ),
        child: SizedBox(
          height: Screens.padingHeight(context),
          child: GridView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: controller.itemlist.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: Screens.padingHeight(context) * 0.03,
              crossAxisSpacing: Screens.width(context) * 0.02,
              childAspectRatio: 1.1,
            ),

            itemBuilder: (context, index) {
              final lists = controller.itemlist[index];
              return InkWell(
                onTap: () {
                  ItemDetailsPage.index = index;
                  Get.toNamed(ConstantRoute.itemdetails);
                },
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: Screens.padingHeight(context) * 0.13,
                          child: Image.network(
                            lists.thumbnail,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;

                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(color: Colors.white),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: Screens.padingHeight(context) * 0.01),
                      SizedBox(
                        width: Screens.width(context) * 0.5,
                        child: Text(
                          lists.title,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontFamily: GoogleFonts.exo2().fontFamily,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
