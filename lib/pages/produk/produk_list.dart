import 'package:flutter/material.dart';
import 'package:xii_rpl_3/models/produk_model.dart';
import 'package:xii_rpl_3/pages/produk/produk_detail.dart';
import 'package:xii_rpl_3/services/produk_serice.dart';

class ProdukListScreen extends StatefulWidget {
  const ProdukListScreen({super.key});

  @override
  State<ProdukListScreen> createState() => _ProdukListScreenState();
}

class _ProdukListScreenState extends State<ProdukListScreen> {
  late Future<List<ProdukModel>> _produkFuture;

  @override
  void initState() {
    super.initState();
    _produkFuture = ProdukService.fetchProdukList();
  }

  // Fungsi format harga ke "$ 1,234.56"
  String formatDollar(double? price) {
    if (price == null) return "\$ 0.00";

    String priceStr = price.toStringAsFixed(2); // dua angka di belakang koma
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
      backgroundColor: Colors.blue.shade100,  // Warna latar biru muda
      appBar: AppBar(
        title: Text("Products"),
        backgroundColor: Colors.blue.shade600,  // AppBar biru lebih gelap
        elevation: 0,
      ),
      body: FutureBuilder<List<ProdukModel>>(
        future: _produkFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text("Produk tidak ditemukan"));

          final produkList = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: produkList.length,
            itemBuilder: (context, index) {
              final produk = produkList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ProdukDetailScreen(productId: produk.id ?? 0),
                    ),
                  );
                },
                child: Card(
                  color: Colors.white,  // Card warna putih
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            produk.image ?? '',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Icon(Icons.image, size: 60, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                produk.title ?? "Tanpa Judul",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                formatDollar(produk.price?.toDouble() ?? 0.0),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
