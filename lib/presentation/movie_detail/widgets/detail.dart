import 'package:flutter/material.dart';
import 'package:my_movie/presentation/movie_detail/widgets/video.dart';

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Video(),
          // MovieDetail(),
        ],
      ),
    );
  }
}
