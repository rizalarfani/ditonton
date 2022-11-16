import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final int voteAverage;
  final String overview;
  final String firstairDate;
  final List<int> genreIds;
  final String name;

  TvSeriesModel({
    this.posterPath,
    required this.popularity,
    required this.id,
    this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstairDate,
    required this.genreIds,
    required this.name,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
