import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TvSeries extends Equatable {
  TvSeries({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstairDate,
    required this.genreIds,
    required this.name,
  });

  String? posterPath;
  double popularity;
  int id;
  String? backdropPath;
  double voteAverage;
  String overview;
  String firstairDate;
  List<dynamic> genreIds;
  String name;

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        firstairDate,
        genreIds,
        name,
      ];
}
