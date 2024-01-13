import 'package:flutter/material.dart';
import 'package:flutter_application_crud/nilai.dart';
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
  TextEditingController _idmahasiswaController = TextEditingController();
  TextEditingController _idmatakuliahController = TextEditingController();
  TextEditingController _nilaiController = TextEditingController();

  int idMatakuliah = 0;

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
                  Text("Id data : $idMatakuliah"),
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
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            Nilai newPost = Nilai(
                              id: 0,
                              idmahasiswa: _idmahasiswaController.text,
                              idmatakuliah: _idmatakuliahController.text,
                              nilai: int.parse(_nilaiController.text),
                            );
                            Nilai createdPost =
                                await _apiService.createNilai(newPost);

                            _idmahasiswaController.clear();
                            _idmatakuliahController.clear();
                            _nilaiController.clear();

                            setState(() {});
                          } catch (e) {
                            // Handle error, misalnya tampilkan snackbar atau pesan kesalahan
                            print("Error creating post: $e");
                          }
                        },
                        child: Text('Create Post'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _idmahasiswaController.clear();
                          _idmatakuliahController.clear();
                          _nilaiController.clear();
                          setState(() {
                            idMatakuliah = 0;
                          });
                        },
                        child: Text('Clear Post'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            Nilai editPost = Nilai(
                              id: idMatakuliah,
                              idmahasiswa: _idmahasiswaController.text,
                              idmatakuliah: _idmatakuliahController.text,
                              nilai: int.parse(_nilaiController.text),
                            );

                            setState(() {
                              idMatakuliah = 0;
                            });

                            _idmahasiswaController.clear();
                            _idmatakuliahController.clear();
                            _nilaiController.clear();

                            await _apiService.updateNilai(editPost);
                            setState(() {});
                          } catch (e) {
                            // Handle error, misalnya tampilkan snackbar atau pesan kesalahan
                            print("Error updating post: $e");
                          }
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
                  return FutureBuilder<List<Nilai>>(
                    future: _apiService.getNilai(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Nilai> posts = snapshot.data!;
                        return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(posts[index].idmahasiswa),
                              subtitle: Text(posts[index].idmatakuliah),
                              trailing: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red),
                                ),
                                onPressed: () async {
                                  _apiService.deleteNilai(posts[index].id);
                                  setState(() {});
                                },
                                child: Text('Delete'),
                              ),
                              onTap: () async {
                                Nilai selectedNilai = await _apiService
                                    .getNilaiById(posts[index].id);

                                idMatakuliah = selectedNilai.id;
                                _idmahasiswaController.text =
                                    selectedNilai.idmahasiswa;
                                _idmatakuliahController.text =
                                    selectedNilai.idmatakuliah;
                                _nilaiController.text =
                                    selectedNilai.nilai.toString();

                                setState(() {
                                  idMatakuliah = selectedNilai.id;
                                  print(idMatakuliah);
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
