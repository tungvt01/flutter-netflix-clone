import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/data/api/entity/movie_entity.dart';
import 'package:netflix_clone/data/api/netflix_api_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Necessary for code-generation to work
// part 'provider.g.dart';
//
// /// This will create a provider named `activityProvider`
// /// which will cache the result of this function.
// @riverpod
// Future<List<MovieEntity>> todayMovies(Ref ref) async {
//   final httpClient = ref.read(netflixApiProvider);
//   return httpClient.getTodayMovies();
// }
