import 'package:flutter/material.dart';
import 'package:flutter_application_crud/nilai.dart';
import 'package:flutter_application_crud/api.dart';

class Update extends StatefulWidget {
  final int id;
  final String idmahasiswa;
  final String idmatakuliah;
  final int nilai;

  Update(this.id, this.idmahasiswa, this.idmatakuliah, this.nilai);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late TextEditingController _idmahasiswaController;
  late TextEditingController _idmatakuliahController;
  late TextEditingController _nilaiController;

  @override
  void initState() {
    super.initState();
    _idmahasiswaController = TextEditingController(text: widget.idmahasiswa);
    _idmatakuliahController = TextEditingController(text: widget.idmatakuliah);
    _nilaiController = TextEditingController(text: widget.nilai.toString());
  }

  @override
  void dispose() {
    _idmahasiswaController.dispose();
    _idmatakuliahController.dispose();
    _nilaiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _idmahasiswaController,
                decoration: InputDecoration(labelText: 'idmahasiswa'),
              ),
              TextFormField(
                controller: _idmatakuliahController,
                decoration: InputDecoration(labelText: 'idmatakuliah'),
              ),
              TextFormField(
                controller: _nilaiController,
                decoration: InputDecoration(labelText: 'nilai'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    Nilai editPost = Nilai(
                      id: widget.id,
                      idmahasiswa: _idmahasiswaController.text,
                      idmatakuliah: _idmatakuliahController.text,
                      nilai: int.parse(_nilaiController.text),
                    );

                    Nilai editedPost = await ApiService().updateNilai(editPost);
                  } catch (e) {
                    // Handle error, misalnya tampilkan snackbar atau pesan kesalahan
                    print("Error updating post: $e");
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
