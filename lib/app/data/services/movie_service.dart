import 'dart:convert';
import 'package:the_movie_explorer/app/core/constants/movie_api_constants.dart';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieApiService {
  Future<List<MovieModel>> searchMovies(String query) async {
    final url = Uri.parse(
      '${MovieApiConstants.baseUrl}/search/movie?api_key=${MovieApiConstants.apiKey}&query=$query',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);

      final List<dynamic> results = jsonBody['results'];

      List<MovieModel> movies = results
          .map((movieJson) => MovieModel.fromMap(movieJson))
          .toList();

      movies.sort((a, b) {
        if (a.releaseDate.isEmpty || b.releaseDate.isEmpty) {
          return a.title.compareTo(b.title);
        }

        DateTime dateA = DateTime.parse(a.releaseDate);
        DateTime dateB = DateTime.parse(b.releaseDate);

        if (dateB.compareTo(dateA) != 0) {
          return dateB.compareTo(dateA);
        }

        return a.title.compareTo(b.title);
      });

      return movies;
    } else {
      throw Exception('Erro ao buscar filmes: ${response.statusCode}');
    }
  }
}
