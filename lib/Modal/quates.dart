import 'dart:convert';
import 'package:flutter/services.dart';

class Quates{
  String keyword;
  int id;
  String quata;

  Quates({
    this.keyword,
    this.id,
    this.quata,

  });

  factory Quates.fromJson(Map<String, dynamic> parsedJson) {
    return Quates(
        id: parsedJson['id'],
        keyword: parsedJson['keyword'] as String,
        quata: parsedJson['quata'] as String,

    );
  }
}


class QuatesViewModel {
  static List<Quates> quates;

  static Future loadQuates() async {
    try {
      quates = new List<Quates>();
      String jsonString = await rootBundle.loadString(
          "assets/quates.json");
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['quates'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        quates.add(new Quates.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}

