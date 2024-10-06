class Movie {
  final String name;
  final String imageUrl;
  final String description;

  Movie({
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json['title'],
      imageUrl: json['big_image'] != null 
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}' // Base URL for images
          : '',
      description: json['description'],
    );
  }
}
