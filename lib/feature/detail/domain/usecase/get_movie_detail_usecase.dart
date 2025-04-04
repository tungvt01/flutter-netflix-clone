import 'package:multiple_result/multiple_result.dart';
import 'package:netflix_clone/data/api/entity/movie_entity.dart';
import 'package:netflix_clone/feature/detail/domain/repository/movie_detail_repository.dart';
import 'package:netflix_clone/shared/exception/api_exception.dart';

abstract class GetMovieDetailUseCase {
  Future<Result<MovieEntity, ApiException>> call({ required int movieId });
}

class GetMovieDetailUseCaseImpl extends GetMovieDetailUseCase {

  final MovieDetailRepository movieDetailRepository;

  GetMovieDetailUseCaseImpl({ required this.movieDetailRepository });

  @override
  Future<Result<MovieEntity, ApiException>> call({ required int movieId }) async {
    try {
       final movie = await movieDetailRepository.getMovieDetail(movieId: movieId);
       return Success(movie);
    } catch (ex) {
      return Error(ApiException());
    }
  }
}