import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/data/api/netflix_api_provider.dart';
import 'package:netflix_clone/feature/detail/data/movie_detail_repository.dart';
import 'package:netflix_clone/feature/detail/domain/repository/movie_detail_repository.dart';

final movieDetailRepositoryProvider = Provider<MovieDetailRepository>((ref) {
  final netflixApi = ref.read(netflixApiProvider);

  return MovieDetailRepositoryImpl(netflixApi: netflixApi);
});