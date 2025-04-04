import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/exception/api_exception.dart';
import '../domain/repository/movie_detail_repository_provider.dart';
import '../state/detail_state.dart';

part 'movie_detail_provider.g.dart';

@riverpod
Future<DetailState> movieDetail(
  Ref ref,
  int movieId,
) async {

  final keepAliveLink = ref.keepAlive();
  final timer = Timer(Duration(seconds: 30), keepAliveLink.close);

  ref.onDispose(timer.cancel);

  final movieDetailRepository = ref.read(movieDetailRepositoryProvider);
  try {
    final movie = await movieDetailRepository.getMovieDetail(movieId: movieId);
    return DetailState(movie: movie);
  } catch (ex) {
    return DetailState(error: ApiException());
  }
}
