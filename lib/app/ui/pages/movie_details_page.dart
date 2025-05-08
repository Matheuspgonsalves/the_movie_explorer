import 'package:flutter/material.dart';
import '../../data/models/movie_model.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (movie.posterPath != null && movie.posterPath!.isNotEmpty)
              Center(
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  height: 300,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 100);
                  },
                ),
              )
            else
              const Center(
                child: Icon(Icons.image_not_supported, size: 100),
              ),
            const SizedBox(height: 16),
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Título Original: ${movie.originalTitle}'),
            const SizedBox(height: 8),
            Text('Idioma Original: ${movie.originalLanguage.toUpperCase()}'),
            const SizedBox(height: 8),
            Text('Data de Lançamento: ${movie.releaseDate}'),
            const SizedBox(height: 8),
            Text('Nota: ${movie.voteAverage.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text('Quantidade de Votos: ${movie.voteCount}'),
            const SizedBox(height: 8),
            Text('Classificação Adulto: ${movie.adult ? "Sim" : "Não"}'),
            const SizedBox(height: 16),
            const Text(
              'Descrição:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              movie.overview,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
