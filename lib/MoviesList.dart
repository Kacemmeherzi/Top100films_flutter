import 'package:app/MovieDetaills.dart';
import 'package:app/movie.dart';
import 'package:flutter/material.dart';

class Movielist extends StatelessWidget {
      final List<Movie> movies = [
  Movie(
    rank:  1,
    title: 'Inception',
    image: 'https://example.com/inception.jpg',
    description: 'A mind-bending thriller about dreams within dreams.',
  ),
  Movie(
    rank: 2,
    title: 'The Dark Knight',
    image: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.primevideo.com%2F-%2Ffr%2Fdetail%2FThe-Dark-Knight%2F0RV4BHZGQV7WWQYA2USRW1B82H&psig=AOvVaw3ahvaUcLq3jgUFtt0y49cL&ust=1727950291643000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCMDx_Me674gDFQAAAAAdAAAAABAE',
    description: 'Batman faces his ultimate nemesis, the Joker, in this gritty crime drama.',
  ),
  Movie(
    rank: 3,
    title: 'Interstellar',
    image: 'https://example.com/interstellar.jpg',
    description: 'A team of explorers travels through a wormhole in') ] ;
   Movielist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("movies")),
         body: Center(
          child : ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context,index ){
              final Movie movie = movies[index] ; 
              return   Card(
                elevation: 8, //shadow 
                child: ListTile(

                  leading: ClipRRect( borderRadius: BorderRadius.circular(7),
                    child: Image.network(movie.image),
                    )  , 
                  title: Text(movie.title),
                  subtitle: Text(movie.description),
                  onTap: (){Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => Moviedetaills(movie: movie)),
  );},
                )
              );
            })
         ),
    );
  }
}