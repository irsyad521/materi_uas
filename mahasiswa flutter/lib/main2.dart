import 'package:flutter/material.dart';
import 'package:flutter_application_crud/mahasiswa.dart';
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
      body: FutureBuilder<List<Mahasiswa>>(
        future: _apiService.getMahasiswa(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          } else {
            List<Mahasiswa> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index].nama),
                  subtitle: Text(posts[index].email),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Example: Creating a new post
          Mahasiswa newPost = Mahasiswa(
              id: 0,
              nama: 'Dodi',
              email: 'dedi@gmail.com',
              tgllahir: '1979-01-01');
          Mahasiswa createdPost = await _apiService.createMahasiswa(newPost);

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
