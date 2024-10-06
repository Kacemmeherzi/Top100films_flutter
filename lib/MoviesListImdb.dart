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

    return const Placeholder();
  }
}