import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_reted_tv_series.dart';
import 'package:ditonton/presentation/provider/top_raled_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_reted_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetTopRaledTvSeries])
main() {
  late MockGetTopRaledTvSeries mockGetTopRaledTvSeries;
  late TopRaledTvSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRaledTvSeries = MockGetTopRaledTvSeries();
    notifier =
        TopRaledTvSeriesNotifier(getTopRaledTvSeries: mockGetTopRaledTvSeries)
          ..addListener(() {
            listenerCallCount++;
          });
  });

  final tTvSeriesList = <TvSeries>[testTvSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRaledTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    notifier.fetchTopRelatedTvSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change Tv Series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTopRaledTvSeries.execute())
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    await notifier.fetchTopRelatedTvSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.listTvSeries, tTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRaledTvSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRelatedTvSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
