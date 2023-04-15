import 'dart:convert';

import 'package:algotest2/models/meme_models.dart';
import 'package:http/http.dart' as http;

class MemeServices {
  String baseUrl = 'https://api.imgflip.com/get_memes';

  Future<List<Meme>> getMemes() async {
    var response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['memes'];
      List<Meme> memes = [];

      for (var item in data) {
        memes.add(Meme.fromJson(item));
      }

      return memes;
    } else {
      throw Exception('Gagal get Memes');
    }
  }
}
