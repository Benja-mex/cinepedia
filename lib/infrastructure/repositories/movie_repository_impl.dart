import 'package:cinemapedia/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl implements MoviesRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImpl({required this.datasource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return await datasource.getNowPlaying(page: page);
  }
}
