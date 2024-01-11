import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List<dynamic> filmData = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final apiKey = '293e22ca'; // Ganti dengan kunci API Anda dari OMDB
    final response = await http.get(Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&s=movie&y=2022'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        filmData = data['Search'].take(5).toList(); // Hanya ambil 5 data
      });
    } else {
      throw Exception('Failed to load film data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Film'),
        foregroundColor: Color(0xffedfcdc),
        backgroundColor: Color(0xff88a26a),
      ),
      body: ListView.builder(
        itemCount: filmData.length * 2 - 1, // Adjust the itemCount
        itemBuilder: (context, index) {
          if (index.isOdd) {
            // Add Divider for odd indices
            return Divider();
          }

          final realIndex = index ~/ 2;
          return ListTile(
            title: Text(filmData[realIndex]['Title']),
            subtitle: Text(filmData[realIndex]['Year']),
          );
        },
      ),
    );
  }
}
