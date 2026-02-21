import 'package:flutter/material.dart';

import 'package:practice_app/Pages/Dashboard/widget/itempage.dart';
import 'package:practice_app/Pages/Dashboard/widget/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboardcrtl extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedindex = 0;
  List<Widget>? nav = [
    ItemsPage(),
    Center(child: Text('Coming Soon', style: TextStyle(color: Colors.white))),
    SettingPage(),
  ];

  bool liked = false;
  likedPress() {
    liked = !liked;
    notifyListeners();
  }

  Future<void> openLink(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
