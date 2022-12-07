import 'package:equatable/equatable.dart';

import 'genre_model.dart';

class TvSeriesDetailModel extends Equatable {
  final String? backdropPath;
  final List<GenreModel> genres;
  final String homePage;
  final int id;
  final bool inProduction;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final int popularity;
  final String posterPath;
  final int voteAverage;
  final int voteCount;

  TvSeriesDetailModel(
      {this.backdropPath,
      required this.genres,
      required this.homePage,
      required this.id,
      required this.inProduction,
      required this.name,
      required this.numberOfEpisodes,
      required this.numberOfSeasons,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount});

  @override
  List<Object?> get props => throw UnimplementedError();
}
