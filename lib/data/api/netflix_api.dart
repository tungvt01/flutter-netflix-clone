import 'package:dio/dio.dart';
import 'package:netflix_clone/data/api/entity/movie_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'netflix_api.g.dart';

@RestApi(baseUrl: 'https://run.mocky.io/v3/')
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('31c82d04-73f7-40d6-8035-b769bce87824')
  Future<List<MovieEntity>> getTodayMovies();
}