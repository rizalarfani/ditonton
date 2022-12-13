import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
import 'package:flutter/cupertino.dart';

import '../../common/state_enum.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendation getTvSeriesRecommendation;

  TvSeriesDetailNotifier(
      {required this.getTvSeriesDetail,
      required this.getTvSeriesRecommendation});

  late TvSeriesDetail _tvSeries;
  TvSeriesDetail get tvSeries => _tvSeries;

  List<TvSeries> _tvSeriesRecommendations = [];
  List<TvSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendation.execute(id);
    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSerie) {
        _recommendationState = RequestState.Loading;
        _tvSeries = tvSerie;
        notifyListeners();
        recommendationResult.fold((failure) {
          _recommendationState = RequestState.Error;
          _message = failure.message;
        }, (tvSeries) {
          _recommendationState = RequestState.Loaded;
          _tvSeriesRecommendations = tvSeries;
        });
        _tvSeriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
