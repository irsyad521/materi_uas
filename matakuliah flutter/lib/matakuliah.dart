class Matakuliah {
  int id;
  String nama;
  String kode;
  int sks;

  Matakuliah(
      {required this.id,
      required this.nama,
      required this.kode,
      required this.sks});

  factory Matakuliah.fromJson(Map<String, dynamic> json) {
    return Matakuliah(
      id: json['id'],
      nama: json['nama'],
      kode: json['kode'],
      sks: json['sks'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'kode': kode,
      'sks': sks,
    };
  }
}
