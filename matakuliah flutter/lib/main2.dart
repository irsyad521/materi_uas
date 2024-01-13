import 'package:flutter/material.dart';
import 'package:flutter_application_crud/matakuliah.dart';
import 'package:flutter_application_crud/api.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Example'),
      ),
      body: FutureBuilder<List<Matakuliah>>(
        future: _apiService.getMatakuliah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          } else {
            List<Matakuliah> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index].nama),
                  subtitle: Text(posts[index].kode),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Example: Creating a new post
          Matakuliah newPost =
              Matakuliah(id: 0, nama: 'Matematika', kode: 'MAT101', sks: 3);
          Matakuliah createdPost = await _apiService.createMatakuliah(newPost);

          // Show a snackbar to notify the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('New entry added: ${createdPost.nama}'),
              duration: Duration(seconds: 2),
            ),
          );

          // Refresh the UI after CRUD operations
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
