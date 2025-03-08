import 'package:flutter/material.dart';

class TopMovieView extends StatelessWidget {
  final double height;

  const TopMovieView({required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Stack(
          children: [
            _MovieBanner(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(children: [
                _NetflixSeriesView(),
                _MovieTitle(),
                _MovieCategories(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieCategories extends StatelessWidget {
  static final _textStyle =  TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red);
  const _MovieCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Text('Emotional', style: _textStyle,),
        Text('Bittersweet', style: _textStyle,),
        Text('Comedy', style: _textStyle,),
      ],
    );
  }
}

class _MovieTitle extends StatelessWidget {
  const _MovieTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Money Heist', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),);
  }
}


class _MovieBanner extends StatelessWidget {
  const _MovieBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 13.5,
      child: Image.asset(
        'assets/images/money_heist_banner.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}

class _NetflixSeriesView extends StatelessWidget {
  const _NetflixSeriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 2,
      children: [
        Image.asset('assets/images/netflix_logo.png', width: 20, height: 20),
        Text(
          'SERIES',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
