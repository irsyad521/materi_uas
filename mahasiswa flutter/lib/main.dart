import 'package:flutter/material.dart';
import 'package:flutter_application_crud/mahasiswa.dart';
import 'package:flutter_application_crud/api.dart';
import 'package:flutter_application_crud/edit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService _apiService = ApiService();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _tgllahirController = TextEditingController();

  int idMahasiswa = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Id data : $idMahasiswa"),
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
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          Mahasiswa newPost = Mahasiswa(
                            id: 0,
                            nama: _namaController.text,
                            email: _emailController.text,
                            tgllahir: _tgllahirController.text,
                          );
                          Mahasiswa createdPost =
                              await _apiService.createMahasiswa(newPost);

                          _namaController.clear();
                          _emailController.clear();
                          _tgllahirController.clear();

                          setState(() {});
                        },
                        child: Text('Create Post'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _namaController.clear();
                          _emailController.clear();
                          _tgllahirController.clear();
                          setState(() {
                            idMahasiswa = 0;
                          });
                        },
                        child: Text('Clear Post'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Mahasiswa editPost = Mahasiswa(
                            id: idMahasiswa,
                            nama: _namaController.text,
                            email: _emailController.text,
                            tgllahir: _tgllahirController.text,
                          );

                          setState(() {
                            idMahasiswa = 0;
                          });

                          _namaController.clear();
                          _emailController.clear();
                          _tgllahirController.clear();

                          await _apiService.updateMahasiswa(editPost);
                          setState(() {});
                        },
                        child: Text('Edit Post'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.all(10),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return FutureBuilder<List<Mahasiswa>>(
                    future: _apiService.getMahasiswa(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Mahasiswa> posts = snapshot.data!;
                        return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(posts[index].nama),
                              subtitle: Text(posts[index].email),
                              trailing: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red),
                                ),
                                onPressed: () async {
                                  _apiService.deleteMahasiswa(posts[index].id);
                                  setState(() {});
                                },
                                child: Text('Delete'),
                              ),
                              onTap: () async {
                                Mahasiswa selectedMahasiswa = await _apiService
                                    .getMahasiswaById(posts[index].id);

                                idMahasiswa = selectedMahasiswa.id;
                                _namaController.text = selectedMahasiswa.nama;
                                _emailController.text = selectedMahasiswa.email;
                                _tgllahirController.text =
                                    selectedMahasiswa.tgllahir;

                                setState(() {
                                  idMahasiswa = selectedMahasiswa.id;
                                  print(idMahasiswa);
                                });
                              },
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
