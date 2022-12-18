import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_on_air_tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_reted_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries, GetTopRaledTvSeries, GetOnAirTvSeries])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRaledTvSeries mockGetTopRaledTvSeries;
  late MockGetOnAirTvSeries mockGetOnAirTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRaledTvSeries = MockGetTopRaledTvSeries();
    mockGetOnAirTvSeries = MockGetOnAirTvSeries();
    provider = TvSeriesListNotifier(
      getTopRaledTvSeries: mockGetTopRaledTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getOnAirTvSeries: mockGetOnAirTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvSeriesList = <TvSeries>[testTvSeries];

  group('On The Air Tv Series', () {
    test('initialState should be Empty', () {
      expect(provider.stateOnAirTvSeries, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnAirTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchOnAirTvSeries();
      // assert
      verify(mockGetOnAirTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnAirTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchOnAirTvSeries();
      // assert
      expect(provider.stateOnAirTvSeries, RequestState.Loading);
    });

    test('should change Tv Series when data is gotten successfully', () async {
      // arrange
      when(mockGetOnAirTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchOnAirTvSeries();
      // assert
      expect(provider.stateOnAirTvSeries, RequestState.Loaded);
      expect(provider.listTvSeriesOnAirTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnAirTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnAirTvSeries();
      // assert
      expect(provider.stateOnAirTvSeries, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular Tv Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchPopularTvSeries();
      // assert
      expect(provider.statePopular, RequestState.Loading);
    });

    test('should change Tv Series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.statePopular, RequestState.Loaded);
      expect(provider.listTvSeriesPopular, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.statePopular, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated Tv Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRaledTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchTopRelatedTvSeries();
      // assert
      expect(provider.stateTopRaled, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRaledTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchTopRelatedTvSeries();
      // assert
      expect(provider.stateTopRaled, RequestState.Loaded);
      expect(provider.listTvSeriesTopRaled, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRaledTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRelatedTvSeries();
      // assert
      expect(provider.stateTopRaled, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
