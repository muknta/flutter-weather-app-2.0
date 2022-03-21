import 'package:injectable/injectable.dart';
import 'package:weather_app_2_0/data/data_sources/remote_data_sources/i_remote_data_source.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';
import 'package:weather_app_2_0/domain/repositories/remote_repositories/i_remote_repository.dart';

@LazySingleton(as: IRemoteRepository)
class RemoteRepository implements IRemoteRepository {
  const RemoteRepository({required IRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  final IRemoteDataSource _remoteDataSource;

  @override
  Future<List<Day>> fetchDailyContent({
    required double latitude,
    required double longitude,
    required String language,
  }) async =>
      _remoteDataSource.fetchDailyContent(latitude: latitude, longitude: longitude, language: language);

  @override
  Future<List<Hour>> fetchHourlyContent({
    required double latitude,
    required double longitude,
    required String language,
  }) async =>
      _remoteDataSource.fetchHourlyContent(latitude: latitude, longitude: longitude, language: language);
}
