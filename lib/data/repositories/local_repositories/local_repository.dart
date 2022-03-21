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

  @override
  Future<List<Day>> getDailyContent() => _localDataSource.getDailyContent();

  @override
  Future<List<Hour>> getHourlyContent() => _localDataSource.getHourlyContent();

  @override
  Future<bool> setDailyContent({required List<Day> content}) => _localDataSource.setDailyContent(content: content);

  @override
  Future<bool> setHourlyContent({required List<Hour> content}) => _localDataSource.setHourlyContent(content: content);
}
