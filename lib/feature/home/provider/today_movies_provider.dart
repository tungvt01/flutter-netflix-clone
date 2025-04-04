import 'dart:async';
import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:netflix_clone/data/api/entity/movie_entity.dart';
import 'package:netflix_clone/data/api/netflix_api_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'today_movies_provider.g.dart';

final myLogger = Logger(
  printer: PrettyPrinter(),
);

// final topTodayMoviesProvider = AutoDisposeFutureProvider<List<MovieEntity>>((ref) async {
//   final httpClient = ref.read(netflixApiProvider);
//
//   final keepAliveLink = ref.keepAlive();
//   final timer = Timer(Duration(seconds: 10), keepAliveLink.close);
//
//   ref.onDispose(timer.cancel);
//
//   return await httpClient.getTodayMovies();
// });

@riverpod
Future<List<MovieEntity>> topTodayMovies(Ref ref) {
  final netflixApi = ref.read(netflixApiProvider);

  final keepAliveLink = ref.keepAlive();
  final timer = Timer(Duration(seconds: 30), keepAliveLink.close);

  ref.onDispose(timer.cancel);

  return netflixApi.getTodayMovies();
}
