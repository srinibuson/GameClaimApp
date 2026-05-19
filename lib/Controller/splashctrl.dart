import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Claimit_app/Constant/constantroute.dart';
import 'package:Claimit_app/Model/giveawaymodel.dart';
import 'package:Claimit_app/Service/giveawayapi.dart';

class SplashCtrl extends ChangeNotifier {
  bool loading = false;
  List<GiveawayModel> itemlist = [];
  init() async {
    await Future.delayed(Duration(seconds: 2));
    await productApiCall();
  }

  productApiCall() async {
    await GiveawayAPI.getData().then((value) {
      if (value.rescode! >= 200 && value.rescode! <= 210) {
        log('200 Success productApiCall');
        itemlist = value.data!;
        notifyListeners();
        Get.offAllNamed(ConstantRoute.loginpage);
      } else if (value.rescode! >= 400 && value.rescode! <= 410) {
        log('400 error productApiCall');
        Get.snackbar(
          '400 Error',
          'SomeThing Went Wrong',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 3),
        );
        notifyListeners();
      } else {
        log('500 error productApiCall');
        Get.snackbar(
          '500 Error',
          'Network Error - Unreachable',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 3),
        );
        notifyListeners();
      }
    });
  }
}
