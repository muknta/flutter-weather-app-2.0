import 'package:weather_app_2_0/data/repository/day/daily_data_repository.dart';
import 'package:weather_app_2_0/domain/repository/day/daily_repository.dart';

import 'api_module.dart';

class DailyRepositoryModule {
  static DailyRepository? _dailyRepository;

  static DailyRepository dailyRepository() => _dailyRepository ??= DailyDataRepository(ApiModule.apiUtil());
}
