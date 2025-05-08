import 'package:flutter/material.dart';
import '../../data/models/movie_model.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {

    Widget _infoRow(String label, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label ',
              style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }


    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          movie.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (movie.posterPath != null && movie.posterPath!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  height: 400,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 100, color: Colors.white70);
                  },
                ),
              ),
            const SizedBox(height: 24),
            Text(
              movie.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            _infoRow('🎬 Título Original:', movie.originalTitle),
            _infoRow('🌐 Idioma:', movie.originalLanguage.toUpperCase()),
            _infoRow('📅 Lançamento:', movie.releaseDate),
            _infoRow('⭐ Nota:', movie.voteAverage.toStringAsFixed(1)),
            _infoRow('👥 Votos:', movie.voteCount.toString()),
            _infoRow('🔞 Adulto:', movie.adult ? 'Sim' : 'Não'),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '📝 Descrição:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              movie.overview.isNotEmpty ? movie.overview : 'Descrição não disponível.',
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );

  }
}
