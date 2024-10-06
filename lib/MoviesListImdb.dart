import 'dart:convert';

import 'package:app/Moviedetaills.dart';
import 'package:app/movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Movieslistimdb extends StatefulWidget {
  const Movieslistimdb({super.key});

  @override
  State<Movieslistimdb> createState() => _MovieslistimdbState();
}

class _MovieslistimdbState extends State<Movieslistimdb> {

late Future<List<Movie>> futureMovies;
  Future<List<Movie>> fetchMovies() async {
    final String apiKey = '771b450204msha3d9833daf12e77p10263bjsnbd0aafc1554f'; 
    final String baseUrl = 'https://imdb-top-100-movies.p.rapidapi.com/';
    final apiheaders = {
       "x-rapidapi-host" :  "imdb-top-100-movies.p.rapidapi.com" , 
       "x-rapidapi-key" : apiKey 

    };
    final response = await http.get(Uri.parse('$baseUrl?api_key=$apiKey'),headers: apiheaders);

   if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((movieJson) => Movie.fromJson(movieJson)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
  }
   @override
  void initState() {
    super.initState();
    this.futureMovies = fetchMovies() ;
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
              
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child:InkWell( onTap: (){
                Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => Moviedetaills(movie: movie)));
              },
                child: 
               Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child: Image.network(
                    movie.image,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                     movie.title,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),












             ) );
            
          },
        );
      },
    );
  }
}