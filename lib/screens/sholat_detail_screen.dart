import 'package:flutter/material.dart';

class SholatDetailScreen extends StatelessWidget {
  final String tanggal;
  final String imsyak;
  final String shubuh;
  final String terbit;
  final String dhuha;
  final String dzuhur;
  final String ashr;
  final String magrib;
  final String isya;

  const SholatDetailScreen({
    super.key,
    required this.tanggal,
    required this.imsyak,
    required this.shubuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashr,
    required this.magrib,
    required this.isya,
  });

  Widget _buildSholatTile(String label, String waktu, IconData icon) {
    return Card(
      color: Colors.green.shade100,
      child: ListTile(
        leading: Icon(icon, color: Colors.green.shade900),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(waktu),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Jadwal Sholat'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSholatTile('Tanggal', tanggal, Icons.calendar_today),
          _buildSholatTile('Imsyak', imsyak, Icons.brightness_2_outlined),
          _buildSholatTile('Shubuh', shubuh, Icons.wb_twilight),
          _buildSholatTile('Terbit', terbit, Icons.wb_sunny),
          _buildSholatTile('Dhuha', dhuha, Icons.sunny),
          _buildSholatTile('Dzuhur', dzuhur, Icons.wb_sunny_outlined),
          _buildSholatTile('Ashr', ashr, Icons.wb_cloudy),
          _buildSholatTile('Magrib', magrib, Icons.nightlight_round),
          _buildSholatTile('Isya', isya, Icons.dark_mode),
        ],
      ),
    );
  }
}
