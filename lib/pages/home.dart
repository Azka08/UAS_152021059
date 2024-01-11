import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_akhir/pages/detail_film.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apiKey = '293e22ca'; // Ganti dengan kunci API OMDB Anda

  Future<List<Map<String, dynamic>>> fetchFilmData() async {
    final response = await http.get(Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&s=movie'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Search'] != null) {
        return List<Map<String, dynamic>>.from(data['Search']);
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Film List'),
        foregroundColor: Color(0xffedfcdc),
        backgroundColor: Color(0xff88a26a),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchFilmData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final filmData = snapshot.data ?? [];

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var film in filmData)
                    FilmCard(
                      posterUrl: film['Poster'] ?? '',
                      title: film['Title'] ?? '',
                      releaseYear: film['Year'] ?? '',
                      imdbID: film['imdbID'] ?? '', // Sertakan imdbID
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class FilmCard extends StatelessWidget {
  final String posterUrl;
  final String title;
  final String releaseYear;
  final String imdbID; // Tambahkan properti imdbID

  const FilmCard({
    required this.posterUrl,
    required this.title,
    required this.releaseYear,
    required this.imdbID, // Tambahkan properti imdbID
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailFilm(
              imdbID: imdbID,
              title: title,
              releaseYear: releaseYear,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              posterUrl,
              height: 200.0,
              width: 150.0,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Release Year: $releaseYear',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
