import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xii_rpl_3/models/produk_model.dart';

class ProdukService {
  static const String baseUrl = 'https://fakestoreapi.com/products';

  static Future<List<ProdukModel>> fetchProdukList() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => ProdukModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data produk');
    }
  }

  static Future<ProdukModel> fetchProdukDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ProdukModel.fromJson(data);
    } else {
      throw Exception('Gagal memuat detail produk');
    }
  }
}
