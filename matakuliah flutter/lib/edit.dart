import 'package:flutter/material.dart';
import 'package:flutter_application_crud/matakuliah.dart';
import 'package:flutter_application_crud/api.dart';

class Update extends StatefulWidget {
  final int id;
  final String nama;
  final String kode;
  final int sks;

  Update(this.id, this.nama, this.kode, this.sks);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late TextEditingController _namaController;
  late TextEditingController _kodeController;
  late TextEditingController _sksController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.nama);
    _kodeController = TextEditingController(text: widget.kode);
    _sksController = TextEditingController(text: widget.sks.toString());
  }

  @override
  void dispose() {
    _namaController.dispose();
    _kodeController.dispose();
    _sksController.dispose();
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
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextFormField(
                controller: _kodeController,
                decoration: InputDecoration(labelText: 'Kode'),
              ),
              TextFormField(
                controller: _sksController,
                decoration: InputDecoration(labelText: 'SKS'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    Matakuliah editPost = Matakuliah(
                      id: widget.id,
                      nama: _namaController.text,
                      kode: _kodeController.text,
                      sks: int.parse(_sksController.text),
                    );

                    Matakuliah editedPost =
                        await ApiService().updateMatakuliah(editPost);
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
