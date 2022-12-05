import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<List<TvSeriesModel>> getOnTheAirTvSeries();
}

class TvSeriesRemoteDataSourceImplement extends TvSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvSeriesRemoteDataSourceImplement({required this.client});

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    Uri url = Uri.parse(BASE_URL + '/tv/popular?$API_KEY');
    Response response = await client.get(url);

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    Uri url = Uri.parse(BASE_URL + '/tv/top_rated?$API_KEY');
    Response response = await client.get(url);

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getOnTheAirTvSeries() async {
    Uri url = Uri.parse(BASE_URL + '/tv/top_rated?$API_KEY');
    Response response = await client.get(url);

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
