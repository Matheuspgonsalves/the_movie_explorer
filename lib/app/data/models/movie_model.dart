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

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] as int ?? 0,
      posterPath: map['poster_path'] ?? 'Null' as String ,
      adult: map['adult'] as bool,
      overview: (map['overview'] ?? 'Null') as String ,
      releaseDate: map['release_date'] ?? 'Null' as String ,
      genreIds:List<int>.from(map['genre_ids'] ?? []),
      originalTitle: map['original_title'] ?? 'Null' as String,
      originalLanguage: map['original_language'] ?? 'Null' as String,
      title: map['title'] ?? 'Null' as String ?? 'Null',
      backdropPath: map['backdrop_path'] ?? 'Null' as String,
      popularity: (map['popularity'] as num).toDouble(),
      voteCount: map['vote_count'] as int,
      voteAverage: (map['vote_average'] as num).toDouble(),
    );
  }

}
