import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/config/dependency_injection.dart';
import 'package:my_movie/presentation/recommendation/blocs/recommendation_bloc.dart';
import 'package:my_movie/presentation/recommendation/widgets/recommend_movies.dart';
import 'package:rive/rive.dart';

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final recommendationBloc = getIt<RecommendationBloc>();
        // movieBloc.add(FetchPopularMovies());
        recommendationBloc.add(LoadRecommendations());
        return recommendationBloc;
      },
      child: const RecommendationContent(),
    );
  }
}

class RecommendationContent extends StatelessWidget {
  const RecommendationContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendation'),
      ),
      body: BlocBuilder<RecommendationBloc, RecommendationState>(
        builder: (context, state) {
          return state is RecommendationLoading
              ? RiveAnimation.asset('assets/animation/loading.riv')
              : SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    children: [
                      RecommendMovies(),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
