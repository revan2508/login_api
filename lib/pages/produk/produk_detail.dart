import 'package:flutter/material.dart';
import 'package:xii_rpl_3/models/produk_model.dart';
import 'package:xii_rpl_3/services/produk_serice.dart';

class ProdukDetailScreen extends StatelessWidget {
  final int productId;

  const ProdukDetailScreen({super.key, required this.productId});

  // Fungsi untuk format harga ke "$ 1,234.56"
  String formatDollar(double? price) {
    if (price == null) return "\$ 0.00";

    String priceStr = price.toStringAsFixed(2); // format dua angka di belakang koma
    final parts = priceStr.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : "00";

    final buffer = StringBuffer();
    int count = 0;

    for (int i = integerPart.length - 1; i >= 0; i--) {
      buffer.write(integerPart[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write(',');
      }
    }

    String formattedInteger = buffer.toString().split('').reversed.join();

    return '\$ $formattedInteger.$decimalPart';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100, // 💙 background biru muda
      appBar: AppBar(
        title: Text("Detail Produk"),
        backgroundColor: Colors.blue.shade600,
      ),
      body: FutureBuilder<ProdukModel>(
        future: ProdukService.fetchProdukDetail(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));
          if (!snapshot.hasData)
            return Center(child: Text("Produk tidak ditemukan"));

          final produk = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          produk.image ?? '',
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Icon(Icons.broken_image, size: 100),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      produk.title ?? "Tanpa Judul",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Category: ${produk.category ?? '-'}",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(height: 12),
                    Text(
                      produk.description ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Price: ${formatDollar(produk.price?.toDouble())}",
                      style:
                          TextStyle(fontSize: 18, color: Colors.green.shade700),
                    ),
                    SizedBox(height: 12),
                    if (produk.rating != null)
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          SizedBox(width: 4),
                          Text(
                            "${produk.rating!.rate} (${produk.rating!.count} Reviews)",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
