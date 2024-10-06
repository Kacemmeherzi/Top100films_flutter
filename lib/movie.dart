class Movie {
  final int rank;
  final String title;
  final String description;
  final String image;
  

  Movie({
    required this.rank,
    required this.title,
    required this.description,
    required this.image,
  
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      rank: json['rank'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
    
    );
  }
}
