import 'dart:convert';
import 'dart:developer';

import 'package:practice_app/Model/giveawaymodel.dart';
import 'package:http/http.dart' as http;

class GiveawayAPI {
  int rescode = 500;

  static Future<GiveawayModelHeader> getData() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.gamerpower.com/api/giveaways'),
      );

      log('Rescode -> ${response.statusCode}');

      if (response.statusCode == 200) {
        return GiveawayModelHeader.fromjson(
          jsonDecode(response.body),
          response.statusCode,
        );
      } else {
        return GiveawayModelHeader.exception(
          jsonDecode(response.body),
          response.statusCode,
        );
      }
    } catch (e) {
      log('GiveawayAPI Catch - $e');
      return GiveawayModelHeader.issue(e.toString(), 500);
    }
  }
}
