import 'package:multiple_result/multiple_result.dart';
import 'package:netflix_clone/data/api/entity/movie_entity.dart';
import 'package:netflix_clone/shared/exception/api_exception.dart';

abstract class MovieDetailRepository {
  Future<MovieEntity> getMovieDetail({ required int movieId });
}