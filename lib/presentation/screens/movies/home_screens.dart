import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static const String name = "Home_screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: _HomeView(),
      ),
      bottomNavigationBar: CustomButtomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider); //todas
    final movies = ref.watch(moviesSlideShowProvider); // solo 6
    final popularMovies = ref.watch(popularMoviesProvider);
    final rateMovies = ref.watch(topRatedMoviesProvider);
    return CustomScrollView(slivers: [
      const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            title: CustomAppbar(),
          )),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            //const CustomAppbar(),
            MoviesSlideShow(movies: movies),
            MoviesHorizontalListView(
              movies: nowPlayingMovies,
              title: "En cines",
              subTitle: "Lunes 20",
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MoviesHorizontalListView(
              movies: nowPlayingMovies,
              title: "Proximamente",
              subTitle: "En este mes",
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MoviesHorizontalListView(
              movies: popularMovies,
              title: "Poupulares",
              //subTitle: "En este mes",
              loadNextPage: () {
                ref.read(popularMoviesProvider.notifier).loadNextPage();
              },
            ),
            MoviesHorizontalListView(
              movies: rateMovies,
              title: "Mejor calificadas",
              subTitle: "Desde siempre",
              loadNextPage: () {
                ref.read(topRatedMoviesProvider.notifier).loadNextPage();
              },
            ),
          ],
        );
      }, childCount: 1))
    ]);
  }
}
