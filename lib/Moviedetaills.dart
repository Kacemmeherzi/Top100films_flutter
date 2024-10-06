import 'package:app/movie.dart';
import 'package:flutter/material.dart';

class Moviedetaills extends StatelessWidget {
 final Movie movie  ; 
  const Moviedetaills(
    {   required this.movie , 
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title:  Text(movie.title),
      ), body : SingleChildScrollView(child:   Column(
          children: [
               Image.network(movie.image),
               Text(movie.title),
               Text(movie.description)

          ],
      ))) ; 
    
  
  }
}