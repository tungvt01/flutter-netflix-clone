import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:netflix_clone/feature/detail/provider/movie_detail_provider.dart';

class DetailScreen extends StatefulHookConsumerWidget {
  final int movieId;

  const DetailScreen({required this.movieId, super.key});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(movieDetailProvider(widget.movieId), (prev, next) {
      if (next case AsyncError(:final error, :final isLoading)) {
        if (isLoading) {
          return;
        }
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error!!'),
              content: Text(error.toString()),
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(movieDetailProvider(widget.movieId));
    return Scaffold(
      body: Center(
        child: RefreshIndicator(
          onRefresh:
              () async => ref.refresh(movieDetailProvider(widget.movieId)),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  if (state.hasValue && state.value!.movie != null)
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: state.value!.movie!.bannerUrl,
                        fit: BoxFit.cover,
                      ),
                    ),

                  Positioned.fill(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (state.isLoading) Text('Is Loading....'),
                            if (state.isRefreshing) Text('Is Refreshing....'),
                            if (state.isReloading) Text('Is Reloading....'),
                            if (state.hasValue &&
                                state.value!.movie != null) ...[
                              Text(
                                'Movie ID: ${state.value!.movie!.id}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                'Movie Name: ${state.value!.movie!.title}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 70,
                      color: Colors.green.withValues(alpha: 0.5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
