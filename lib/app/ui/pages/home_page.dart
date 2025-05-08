import 'package:flutter/material.dart';
import 'package:the_movie_explorer/app/data/models/movie_model.dart';
import 'package:the_movie_explorer/app/data/services/movie_service.dart';
import 'package:the_movie_explorer/app/ui/pages/movie_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final MovieApiService _movieApiService = MovieApiService();
  Future<List<MovieModel>>? _moviesFuture;

  void _searchMovies() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      setState(() {
        _moviesFuture = _movieApiService.searchMovies(query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '🎬 Movie Explorer',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Descubra e explora filmes incríveis',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _searchMovies(),
              onChanged: (value) {
                if (value.trim().length >= 3) {
                  _searchMovies();
                }
              },
              decoration: const InputDecoration(
                hintText: 'Digite o nome do filme',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _moviesFuture == null
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.movie_filter_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Busque por um filme',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              )
                  : FutureBuilder<List<MovieModel>>(
                future: _moviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final movies = snapshot.data!;
                    if (movies.isEmpty) {
                      return const Center(child: Text('Nenhum filme encontrado.'));
                    }
                    return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return Card(
                          color: const Color(0xFF1E1E1E), // fundo mais escuro e estiloso
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            leading: movie.posterPath != null && movie.posterPath!.isNotEmpty
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                width: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.broken_image, color: Colors.white70);
                                },
                              ),
                            )
                                : const Icon(Icons.image_not_supported, color: Colors.white54),
                            title: Text(
                              movie.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Data de lançamento: ${movie.releaseDate}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: Text(
                              movie.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(color: Colors.white70),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailsPage(movie: movie),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('Nenhum resultado.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
