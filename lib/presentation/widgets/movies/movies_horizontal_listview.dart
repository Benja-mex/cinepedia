import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/movies.dart';

class MoviesHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;
  const MoviesHorizontalListView(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MoviesHorizontalListView> createState() =>
      _MoviesHorizontalListViewState();
}

class _MoviesHorizontalListViewState extends State<MoviesHorizontalListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if (_scrollController.position.pixels + 200 >=
          _scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Title(title: widget.title, subTitle: widget.subTitle),
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final movie = widget.movies[index];
                  return _Slide(movie);
                },
                itemCount: widget.movies.length,
                scrollDirection: Axis.horizontal),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide(this.movie);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final theme = Theme.of(context).colorScheme;
    final titleStyle = textStyle.titleSmall
        ?.copyWith(color: theme.primary, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: Image.network(
                  fit: BoxFit.cover,
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                          ? FadeInRight(child: child)
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: titleStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(
                  Icons.star_half_outlined,
                  color: theme.inversePrimary,
                ),
                const SizedBox(width: 5),
                Text(
                  movie.voteAverage.toString(),
                  style: textStyle.bodyMedium?.copyWith(
                    color: theme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  movie.popularity.toHumanFormat(),
                  style: textStyle.bodySmall?.copyWith(
                    color: theme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(color: theme.primary, fontWeight: FontWeight.bold);
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(
                subTitle!,
                style: TextStyle(
                    color: theme.primary, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
