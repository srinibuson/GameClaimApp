// screens/favourites_screen.dart
import 'package:Claimit_app/Constant/constantroute.dart';
import 'package:Claimit_app/Constant/screens.dart';
import 'package:Claimit_app/Pages/Dashboard/widget/itemdetails.dart';
import 'package:Claimit_app/Service/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class FavouritesScreen extends StatelessWidget {
  final _service = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _service.likedItemsStream(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final items = snapshot.data ?? [];

        // Empty state
        if (items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 64, color: Colors.white24),
                SizedBox(height: 16),
                Text(
                  'No saved giveaways yet',
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Tap ♥ on any game to save it here',
                  style: TextStyle(color: Colors.white38, fontSize: 13),
                ),
              ],
            ),
          );
        }

        // Grid same as home
        return Container(
          padding: EdgeInsets.only(
            // top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.03,
            right: Screens.width(context) * 0.03,
          ),
          child: SizedBox(
            height: Screens.padingHeight(context),
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: Screens.padingHeight(context) * 0.03,
                crossAxisSpacing: Screens.width(context) * 0.02,
                childAspectRatio: 1.1,
              ),

              itemBuilder: (context, index) {
                final lists = items[index];
                return InkWell(
                  onTap: () {
                    // Get.toNamed(ConstantRoute.itemdetails);
                    Get.to(
                      () => ItemDetailsPage(gameData: lists),
                      transition: Transition.cupertino,
                      duration: Duration(seconds: 2),
                    );
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
                              lists['thumbnail'] ?? '',
                              fit: BoxFit.cover,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
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
                            lists['title'] ?? '',
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
        );
      },
    );
  }
}

class FavouriteCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final _service = FirestoreService();

  FavouriteCard({required this.data, super.key});

  void _unlike() {
    _service.toggleLike(data); // StreamBuilder auto-updates UI
  }

  @override
  Widget build(BuildContext context) {
    final worth = data['worth'];
    final hasWorth = worth != null && worth != 'N/A';

    return GestureDetector(
      onTap: () {
        // Navigate to detail page
        // Get.to(() => DetailScreen(gameData: data));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Thumbnail
            Image.network(
              data['thumbnail'] ?? '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.grey[900]),
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.85)],
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Unlike button top right
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: _unlike,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Worth badge
                  if (hasWorth)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      margin: const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        worth,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  // Title
                  Text(
                    data['title'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Platform
                  Text(
                    data['platforms'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white60, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
