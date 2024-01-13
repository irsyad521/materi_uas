import 'package:flutter/material.dart';
import 'package:flutter_application_crud/nilai.dart';
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
      body: FutureBuilder<List<Nilai>>(
        future: _apiService.getNilai(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          } else {
            List<Nilai> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index].idmahasiswa),
                  subtitle: Text(posts[index].idmatakuliah),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Example: Creating a new post
          Nilai newPost = Nilai(
              id: 0,
              idmahasiswa: 'Matematika',
              idmatakuliah: 'MAT101',
              nilai: 3);
          Nilai createdPost = await _apiService.createNilai(newPost);

          // Show a snackbar to notify the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('New entry added: ${createdPost.idmahasiswa}'),
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
