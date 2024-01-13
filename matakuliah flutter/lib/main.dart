import 'package:flutter/material.dart';
import 'package:flutter_application_crud/matakuliah.dart';
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
  TextEditingController _kodeController = TextEditingController();
  TextEditingController _sksController = TextEditingController();

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
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            Matakuliah newPost = Matakuliah(
                              id: 0,
                              nama: _namaController.text,
                              kode: _kodeController.text,
                              sks: int.parse(_sksController.text),
                            );
                            Matakuliah createdPost =
                                await _apiService.createMatakuliah(newPost);

                            _namaController.clear();
                            _kodeController.clear();
                            _sksController.clear();

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
                          _namaController.clear();
                          _kodeController.clear();
                          _sksController.clear();
                          setState(() {
                            idMatakuliah = 0;
                          });
                        },
                        child: Text('Clear Post'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            Matakuliah editPost = Matakuliah(
                              id: idMatakuliah,
                              nama: _namaController.text,
                              kode: _kodeController.text,
                              sks: int.parse(_sksController.text),
                            );

                            setState(() {
                              idMatakuliah = 0;
                            });

                            _namaController.clear();
                            _kodeController.clear();
                            _sksController.clear();

                            await _apiService.updateMatakuliah(editPost);
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
                  return FutureBuilder<List<Matakuliah>>(
                    future: _apiService.getMatakuliah(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Matakuliah> posts = snapshot.data!;
                        return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(posts[index].nama),
                              subtitle: Text(posts[index].kode),
                              trailing: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red),
                                ),
                                onPressed: () async {
                                  _apiService.deleteMatakuliah(posts[index].id);
                                  setState(() {});
                                },
                                child: Text('Delete'),
                              ),
                              onTap: () async {
                                Matakuliah selectedMatakuliah =
                                    await _apiService
                                        .getMatakuliahById(posts[index].id);

                                idMatakuliah = selectedMatakuliah.id;
                                _namaController.text = selectedMatakuliah.nama;
                                _kodeController.text = selectedMatakuliah.kode;
                                _sksController.text =
                                    selectedMatakuliah.sks.toString();

                                setState(() {
                                  idMatakuliah = selectedMatakuliah.id;
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
