import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Claimit_app/Constant/constantroute.dart';
import 'package:Claimit_app/Model/giveawaymodel.dart';
import 'package:Claimit_app/Service/giveawayapi.dart';

class SplashCtrl extends ChangeNotifier {
  bool loading = false;
  init() async {
    await productApiCall();
    await Future.delayed(Duration(seconds: 2));
    Get.offAllNamed(ConstantRoute.loginpage);
  }

  List<GiveawayModel> itemlist = [];

  productApiCall() async {
    await GiveawayAPI.getData().then((value) {
      if (value.rescode! >= 200 && value.rescode! <= 210) {
        itemlist = value.data!;
        notifyListeners();
      } else if (value.rescode! >= 400 && value.rescode! <= 410) {
        log('400 error productApiCall');
      } else {
        log('500 error productApiCall');
      }
    });
  }
}
