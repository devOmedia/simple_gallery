import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:math' as math show pi;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final imageUrls = [
    'https://bit.ly/3x7J5Qt',
    'https://bit.ly/3ywI8l6',
    'https://bit.ly/3jOueGG',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Gallery'),
      ),
      body: Center(
        heightFactor: 1.5,
        child: FractionallySizedBox(
          widthFactor: 0.6,
          heightFactor: 0.4,
          child: Transform.translate(
            offset: const Offset(20.0, 0.0),
            child: Transform.rotate(
              angle: 10.asDegreeToRadians(),
              child: Stack(
                children: imageUrls
                    .mapWithIndexAndCount((index, count, url) =>
                        NetworkImage(index: count - index - 1, url: url))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension AsDegreesToRadians<T extends num> on T {
  double asDegreeToRadians() => toDouble() * (math.pi / 180.0);
}

extension IterationWithIndex<T> on Iterable<T> {
  Iterable<E> mapWithIndexAndCount<E>(
    E Function(int index, int count, T value) f,
  ) =>
      Iterable.generate(length, (i) => f(i, length, elementAt(i)));
}

class NetworkImage extends StatelessWidget {
  final int index;
  final String url;
  const NetworkImage({Key? key, required this.index, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -((index * 10.0).asDegreeToRadians()),
      child: Transform.translate(
        offset: Offset(-20.0 * index.toDouble(), 0.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            url,
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
