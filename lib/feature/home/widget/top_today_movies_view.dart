import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TopTodayMoviesView extends StatelessWidget {
  const TopTodayMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 100,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...[
              'assets/images/the_lord_of_the_ring_thumbnail.jpg',
              'assets/images/the_lord_of_the_ring_thumbnail.jpg',
              'assets/images/the_lord_of_the_ring_thumbnail.jpg',
              'assets/images/the_lord_of_the_ring_thumbnail.jpg',
              'assets/images/the_lord_of_the_ring_thumbnail.jpg',
            ].asMap().entries.map<Widget>((a) => _MovieItem(assetBanner: a.value, index: a.key + 1)),
          ],
        ),
      ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  final String assetBanner;
  final int index;

  const _MovieItem({required this.assetBanner, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      color: Colors.black,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Text(
              '$index',
              style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.w700,
                foreground:
                    Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 40,
            right: 0,
            child: Image.asset(assetBanner, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
