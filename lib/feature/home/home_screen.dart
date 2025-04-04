import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:netflix_clone/data/api/provider.dart';
import 'package:netflix_clone/feature/home/provider/today_movies_provider.dart';
import 'package:netflix_clone/feature/home/widget/gradient_background_view.dart';
import 'package:netflix_clone/feature/home/widget/home_header_view.dart';
import 'package:netflix_clone/feature/home/widget/top_movie_view.dart';

import 'widget/top_today_movies_view.dart';

final double actionViewHeight = 45;
final double categoryViewHeight = 60;

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,   WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;

    final scrollController = useScrollController();
    final isCategoryVisible = useState(true);
    final isBlurBackgroundVisible = useState(false);
    var lastOffsetWhenDirectionChanged = useRef(0.0);
    var lastScrollDirection = useRef(ScrollDirection.forward);

    void scrollListener() {
      final offset = scrollController.offset;
      // ignore: lines_longer_than_80_chars
      final currentScrollDirection = scrollController.position.userScrollDirection;

      isBlurBackgroundVisible.value = offset > 40;

      if (lastScrollDirection.value != currentScrollDirection) {
        lastScrollDirection.value = currentScrollDirection;
        lastOffsetWhenDirectionChanged.value = offset;
      }
      if ((offset - lastOffsetWhenDirectionChanged.value).abs() >= 100) {
        isCategoryVisible.value = currentScrollDirection == ScrollDirection.forward;
      }
    }

    useEffect(() {
      scrollController.addListener(scrollListener);
      return () => scrollController.removeListener(scrollListener);
    }, [],);

    return Stack(
      children: <Widget>[
        GradientBackgroundView(),
        RefreshIndicator(
        onRefresh: () => ref.refresh(topTodayMoviesProvider.future),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: topPadding + actionViewHeight + categoryViewHeight + 20,
            ),
            child: Column(
              children: [
                TopMovieView(height: mediaQuery.size.height * 0.6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TopTodayMoviesView(),
                ),
                ...List.generate(200, (index) {
                  return Center(child: Text('Move item $index'));
                }),
              ],
            ),
          ),
        ),
        HomeHeaderView(
          isCategoryPresented: isCategoryVisible.value,
          isBlurBackgroundPresented: isBlurBackgroundVisible.value,
        ),
      ],
    );
  }
}
