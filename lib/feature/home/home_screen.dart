import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_clone/feature/home/widget/home_header_view.dart';
import 'package:netflix_clone/feature/home/widget/gradient_background_view.dart';
import 'package:netflix_clone/feature/home/widget/top_movie_view.dart';

final double actionViewHeight = 45;
final double categoryViewHeight = 60;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  var _isCategoryPresented = true;
  var _isBlurBackgroundPresented = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      if ((_scrollController.offset - _scrollController.initialScrollOffset).abs() < 40) {
        return;
      }
      _isCategoryPresented =
          _scrollController.position.userScrollDirection ==
          ScrollDirection.forward;
      _isBlurBackgroundPresented = _scrollController.offset > 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;

    return Stack(
      children: <Widget>[
        GradientBackgroundView(),
        SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.only(
            top: topPadding + actionViewHeight + categoryViewHeight + 20,
          ),
          child: Column(
            children: [
              TopMovieView(height: mediaQuery.size.height * 0.6),
              ...List.generate(200, (index) {
                return Center(child: Text('Move item $index'));
              }),
            ],
          ),
        ),
        HomeHeaderView(
          isCategoryPresented: _isCategoryPresented,
          isBlurBackgroundPresented: _isBlurBackgroundPresented,
        ),
      ],
    );
  }
}
