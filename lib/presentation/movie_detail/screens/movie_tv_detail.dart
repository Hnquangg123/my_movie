import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/config/dependency_injection.dart';
import 'package:my_movie/presentation/movie_detail/blocs/detail/detail_bloc.dart';
import 'package:my_movie/presentation/movie_detail/blocs/video/video_bloc.dart';
import 'package:my_movie/presentation/movie_detail/widgets/detail.dart';

class MovieTVDetail extends StatelessWidget {
  final int movieTVId;

  const MovieTVDetail({super.key, required this.movieTVId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final detailBloc = getIt<DetailBloc>();
            detailBloc.add(FetchMovieDetail(id: movieTVId));
            return detailBloc;
          },
        ),
        BlocProvider(
          create: (context) {
            final videoBloc = getIt<VideoBloc>();
            videoBloc.add(FetchVideos(id: movieTVId));
            return videoBloc;
          },
        ),
      ],
      child: Detail(),
    );
  }
}
