import 'dart:convert';

import 'package:app/movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Movieslistimdb extends StatefulWidget {
  const Movieslistimdb({super.key});

  @override
  State<Movieslistimdb> createState() => _MovieslistimdbState();
}

class _MovieslistimdbState extends State<Movieslistimdb> {

  List<Movie> movies = [] ;
  Future<List<Movie>> fetchMovies() async {
    final String apiKey = '771b450204msha3d9833daf12e77p10263bjsnbd0aafc1554f'; 
    final String baseUrl = 'https://imdb-top-100-movies.p.rapidapi.com/';
    final apiheaders = {
       "x-rapidapi-host" :  "imdb-top-100-movies.p.rapidapi.com" , 
       "x-rapidapi-key" : apiKey 

    };
    final response = await http.get(Uri.parse('$baseUrl?api_key=$apiKey'),headers: apiheaders);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> results = json['results'];

      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Movie>>(
      future:fetchMovies(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Loading indicator
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Error message
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No movies found.')); // No data message
        }

        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(movie.name),
                
                leading: Image.network(movie.imageUrl),
              ),
            );
          },
        );
      },
    );
  }
}