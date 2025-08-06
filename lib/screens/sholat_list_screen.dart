import 'package:flutter/material.dart';
import '../models/sholat_model.dart';
import '../services/sholat_services.dart';
import 'sholat_detail_screen.dart';

class SholatListScreen extends StatelessWidget {
  const SholatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Sholat'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<SholatModel>>(
        future: SholatService.fetchJadwalSholat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Data kosong'));
          }

          final jadwal = snapshot.data!;

          return ListView.builder(
            itemCount: jadwal.length,
            itemBuilder: (context, index) {
              final item = jadwal[index];
              return Card(
                color: Colors.green.shade50,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.green),
                  title: Text('Tanggal: ${item.tanggal ?? '-'}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Shubuh: ${item.shubuh ?? '-'}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SholatDetailScreen(
                          tanggal: item.tanggal ?? '',
                          imsyak: item.imsyak ?? '',
                          shubuh: item.shubuh ?? '',
                          terbit: item.terbit ?? '',
                          dhuha: item.dhuha ?? '',
                          dzuhur: item.dzuhur ?? '',
                          ashr: item.ashr ?? '',
                          magrib: item.magrib ?? '',
                          isya: item.isya ?? '',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
