import 'package:netflix_clone/data/api/entity/movie_entity.dart';
import 'package:netflix_clone/data/api/netflix_api.dart';

import '../domain/repository/movie_detail_repository.dart';

class MovieDetailRepositoryImpl extends MovieDetailRepository {
  final RestClient netflixApi;

  MovieDetailRepositoryImpl({required this.netflixApi });

  @override
  Future<MovieEntity> getMovieDetail({ required int movieId }) async {
    final movies = await netflixApi.getTodayMovies(); // fake api

    return movies.firstWhere((m) => m.id == movieId, orElse: () => movies[0]) ;
  }

}