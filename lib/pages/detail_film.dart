import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailFilm extends StatefulWidget {
  final String title;
  final String releaseYear;
  final String imdbID;

  const DetailFilm({
    required this.title,
    required this.releaseYear,
    required this.imdbID,
  });

  @override
  _DetailFilmState createState() => _DetailFilmState();
}

class _DetailFilmState extends State<DetailFilm> {
  late String description;

  @override
  void initState() {
    super.initState();
    fetchFilmDetails();
  }

  Future<void> fetchFilmDetails() async {
    final apiKey = '293e22ca';
    final response = await http.get(Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&i=${widget.imdbID}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        description = data['Plot'] ?? 'No description available';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Film Detail'),
        foregroundColor: Color(0xffedfcdc),
        backgroundColor: Color(0xff88a26a),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Release Year: ${widget.releaseYear}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description: $description',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}