class MovieModel {
  final int id; 
  final String? posterPath;
  final bool adult;
  final String overview;
  final String releaseDate;
  final List<int> genreIds;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String? backdropPath;
  final double popularity;
  final int voteCount;
  final double voteAverage;

  MovieModel(
  {
    required this.id,
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.voteAverage
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'poster_path': this.posterPath,
      'adult': this.adult,
      'overview': this.overview,
      'release_date': this.releaseDate,
      'genre_ids': this.genreIds,
      'original_title': this.originalTitle,
      'original_language': this.originalLanguage,
      'title': this.title,
      'backdrop_path': this.backdropPath,
      'popularity': this.popularity,
      'vote_count': this.voteCount,
      'vote_average': this.voteAverage,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] as int,
      posterPath: map['poster_path'] as String,
      adult: map['adult'] as bool,
      overview: map['overview'] as String,
      releaseDate: map['release_date'] as String,
      genreIds:List<int>.from(map['genre_ids']),
      originalTitle: map['original_title'] as String,
      originalLanguage: map['original_language'] as String,
      title: map['title'] as String,
      backdropPath: map['backdrop_path'] as String,
      popularity: (map['popularity'] as num).toDouble(),
      voteCount: map['vote_count'] as int,
      voteAverage: (map['vote_average'] as num).toDouble(),
    );
  }

}
