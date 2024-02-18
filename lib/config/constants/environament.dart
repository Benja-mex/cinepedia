import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String thenMovieDbKey =
      dotenv.env['THE_MOVIEDB_KEY'] ?? "No key";
}
