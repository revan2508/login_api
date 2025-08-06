class SholatModel {
  String? imsyak;
  String? shubuh;
  String? dzuhur;
  String? tanggal;
  String? terbit;
  String? magrib;
  String? isya;
  String? dhuha;
  String? ashr;

  SholatModel({
    this.imsyak,
    this.shubuh,
    this.dzuhur,
    this.tanggal,
    this.terbit,
    this.magrib,
    this.isya,
    this.dhuha,
    this.ashr,
  });

  SholatModel.fromJson(Map<String, dynamic> json) {
    imsyak = json['imsyak'];
    shubuh = json['shubuh'];
    dzuhur = json['dzuhur'];
    tanggal = json['tanggal'];
    terbit = json['terbit'];
    magrib = json['magrib'];
    isya = json['isya'];
    dhuha = json['dhuha'];
    ashr = json['ashr'];
  }

  Map<String, dynamic> toJson() {
    return {
      'imsyak': imsyak,
      'shubuh': shubuh,
      'dzuhur': dzuhur,
      'tanggal': tanggal,
      'terbit': terbit,
      'magrib': magrib,
      'isya': isya,
      'dhuha': dhuha,
      'ashr': ashr,
    };
  }
}
