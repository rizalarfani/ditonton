import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/provider/on_air_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_list_notifier_test.mocks.dart';

void main() {
  late MockGetOnAirTvSeries mockGetOnAirTvSeries;
  late OnAirTvSeriesNotifier provider;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetOnAirTvSeries = MockGetOnAirTvSeries();
      provider = OnAirTvSeriesNotifier(getOnAirTvSeries: mockGetOnAirTvSeries)
        ..addListener(
          () {
            listenerCallCount++;
          },
        );
    },
  );

  final tTvSeriesList = <TvSeries>[testTvSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetOnAirTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    provider.fetchOnAirTvSeries();
    // assert
    expect(provider.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetOnAirTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    await provider.fetchOnAirTvSeries();
    // assert
    expect(provider.state, RequestState.Loaded);
    expect(provider.listTvSeries, tTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetOnAirTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await provider.fetchOnAirTvSeries();
    // assert
    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
