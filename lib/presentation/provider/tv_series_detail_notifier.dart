import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter/cupertino.dart';

import '../../common/state_enum.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  final GetTvSeriesDetail getTvSeriesDetail;

  TvSeriesDetailNotifier({required this.getTvSeriesDetail});

  late TvSeriesDetail _tvSeries;
  TvSeriesDetail get tvSeries => _tvSeries;

  RequestState _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesDetail(int id) async {
    _movieState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    detailResult.fold(
      (failure) {
        _movieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _tvSeries = tvSeries;
        notifyListeners();
        _movieState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
