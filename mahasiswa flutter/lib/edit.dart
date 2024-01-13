import 'package:flutter/material.dart';
import 'package:flutter_application_crud/mahasiswa.dart';
import 'package:flutter_application_crud/api.dart';

class Update extends StatefulWidget {
  final int id;
  final String nama;
  final String email;
  final String tgllahir;

  Update(this.id, this.nama, this.email, this.tgllahir);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  late TextEditingController _namaController;
  late TextEditingController _emailController;
  late TextEditingController _tgllahirController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controllers dan set nilai awal
    _namaController = TextEditingController(text: widget.nama);
    _emailController = TextEditingController(text: widget.email);
    _tgllahirController = TextEditingController(text: widget.tgllahir);
  }

  @override
  void dispose() {
    // Hapus controller saat widget dihilangkan
    _namaController.dispose();
    _emailController.dispose();
    _tgllahirController.dispose();
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
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _tgllahirController,
                decoration: InputDecoration(labelText: 'Tgl Lahir'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Mahasiswa editPost = Mahasiswa(
                    id: widget.id,
                    nama: _namaController.text,
                    email: _emailController.text,
                    tgllahir: _tgllahirController.text,
                  );

                  print(_namaController.text);

                  // Cetak log untuk memeriksa apakah data yang diperbarui benar-benar dikirim ke server
                  // print("Updating post: ${editPost.id}");

                  Mahasiswa editedPost =
                      await ApiService().updateMahasiswa(editPost);
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
