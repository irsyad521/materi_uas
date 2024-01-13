import 'dart:convert';

import 'package:flutter_application_crud/matakuliah.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.183.117:8080/api/v1/matakuliah';

  Future<List<Matakuliah>> getMatakuliah() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Iterable<dynamic> data = json.decode(response.body);
      return data.map((json) => Matakuliah.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load matakuliah');
    }
  }

  Future<Matakuliah> getMatakuliahById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      return Matakuliah.fromJson(data);
    } else {
      throw Exception('Failed to load matakuliah by ID');
    }
  }

  Future<Matakuliah> createMatakuliah(Matakuliah matakuliah) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(matakuliah.toJson()),
    );

    if (response.statusCode == 200) {
      return Matakuliah.fromJson(json.decode(response.body));
    } else {
      print("Failed to create matakuliah. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      throw Exception('Failed to create matakuliah');
    }
  }

  Future<Matakuliah> updateMatakuliah(Matakuliah matakuliah) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${matakuliah.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': matakuliah.id,
        'nama': matakuliah.nama,
        'kode': matakuliah.kode,
        'sks': matakuliah.sks,
      }),
    );

    print("Response from server: ${response.body}");
    print(matakuliah.nama);
    print(matakuliah.id);
    print(matakuliah.sks);

    if (response.statusCode == 200) {
      print("Update successful");
      return Matakuliah.fromJson(json.decode(response.body));
    } else {
      print("Update failed");
      throw Exception('Failed to update matakuliah');
    }
  }

  Future<void> deleteMatakuliah(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      print("Deletion successful");
    } else {
      print("Deletion failed. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      throw Exception('Failed to delete matakuliah');
    }
  }
}
