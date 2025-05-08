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
        title: const Text('Buscar Filmes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Digite o nome do filme',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _searchMovies,
                  child: const Icon(Icons.search),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _moviesFuture == null
                  ? const Center(child: Text('Busque por um filme!'))
                  : FutureBuilder<List<MovieModel>>(
                future: _moviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Erro: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    final movies = snapshot.data!;
                    if (movies.isEmpty) {
                      return const Center(
                        child: Text('Nenhum filme encontrado.'),
                      );
                    }
                    return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: movie.posterPath != null && movie.posterPath!.isNotEmpty
                                ? Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              width: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image);
                              },
                            )
                                : const Icon(Icons.image_not_supported),
                            title: Text(movie.title),
                            subtitle: Text('Data de lançamento: ${movie.releaseDate}'),
                            trailing: Text(movie.voteAverage.toString()),
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
