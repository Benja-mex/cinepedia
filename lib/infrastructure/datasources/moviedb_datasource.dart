import 'package:cinemapedia/config/constants/environament.dart';
import 'package:cinemapedia/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MovieDbDataSource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {
      "api_key": Environment.thenMovieDbKey,
      "language": "es-MX",
    },
  ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get("/movie/now_playing", queryParameters: {
      "page": page,
    });
    final moviedbResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = moviedbResponse.results
        .where((movidb) => movidb.posterPath != "no-poster")
        .map((e) => MovieMapper.movieDBToEntity(e))
        .toList();
    return movies;
  }
}
