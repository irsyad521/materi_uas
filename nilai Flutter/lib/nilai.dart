class Nilai {
  int id;
  String idmahasiswa;
  String idmatakuliah;
  int nilai;

  Nilai(
      {required this.id,
      required this.idmahasiswa,
      required this.idmatakuliah,
      required this.nilai});

  factory Nilai.fromJson(Map<String, dynamic> json) {
    return Nilai(
      id: json['id'],
      idmahasiswa: json['idmahasiswa'],
      idmatakuliah: json['idmatakuliah'],
      nilai: json['nilai'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idmahasiswa': idmahasiswa,
      'idmatakuliah': idmatakuliah,
      'nilai': nilai,
    };
  }
}
