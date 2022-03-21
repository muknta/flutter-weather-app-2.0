import 'package:injectable/injectable.dart';
import 'package:weather_app_2_0/data/data_sources/local_data_sources/i_local_data_source.dart';
import 'package:weather_app_2_0/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:weather_app_2_0/domain/model/day/day.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';

@LazySingleton(as: ILocalRepository)
class LocalRepository implements ILocalRepository {
  const LocalRepository({
    required ILocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final ILocalDataSource _localDataSource;

  Future<List<Day>> getDailyContent();
  Future<void> setDailyContent({required List<Day> content});

  Future<List<Hour>> getHourlyContent();
  Future<void> setHourlyContent({required List<Hour> content});
}
