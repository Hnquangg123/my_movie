import 'package:flutter/material.dart';
import 'package:my_movie/presentation/movie_detail/widgets/movie_detail.dart';
import 'package:my_movie/presentation/movie_detail/widgets/video.dart';

class Detail extends StatelessWidget {
  final String mediaType;

  const Detail({super.key, required this.mediaType});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Video(),
          MovieDetailWidget(mediaType: mediaType),
        ],
      ),
    );
  }
}
