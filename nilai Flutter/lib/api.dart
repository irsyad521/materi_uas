import 'dart:convert';

import 'package:flutter_application_crud/nilai.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.183.117:8080/api/v1/nilai';

  Future<List<Nilai>> getNilai() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Iterable<dynamic> data = json.decode(response.body);
      return data.map((json) => Nilai.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Nilai');
    }
  }

  Future<Nilai> getNilaiById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      return Nilai.fromJson(data);
    } else {
      throw Exception('Failed to load Nilai by ID');
    }
  }

  Future<Nilai> createNilai(Nilai nilai) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(nilai.toJson()),
    );

    if (response.statusCode == 200) {
      return Nilai.fromJson(json.decode(response.body));
    } else {
      print("Failed to create Nilai. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      throw Exception('Failed to create Nilai');
    }
  }

  Future<Nilai> updateNilai(Nilai nilai) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${nilai.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': nilai.id,
        'idmahasiswa': nilai.idmahasiswa,
        'idmatakuliah': nilai.idmatakuliah,
        'nilai': nilai.nilai,
      }),
    );

    print("Response from server: ${response.body}");
    print(nilai.idmahasiswa);
    print(nilai.id);
    print(nilai.nilai);

    if (response.statusCode == 200) {
      print("Update successful");
      return Nilai.fromJson(json.decode(response.body));
    } else {
      print("Update failed");
      throw Exception('Failed to update Nilai');
    }
  }

  Future<void> deleteNilai(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      print("Deletion successful");
    } else {
      print("Deletion failed. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      throw Exception('Failed to delete Nilai');
    }
  }
}
