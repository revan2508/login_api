import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sholat_model.dart';

class SholatService {
  static const String sholatUrl = 'https://raw.githubusercontent.com/lakuapik/jadwalsholatorg/master/adzan/semarang/2019/12.json';

  static Future<List<SholatModel>> fetchJadwalSholat() async {
    final response = await http.get(Uri.parse(sholatUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => SholatModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat jadwal sholat');
    }
  }
}
