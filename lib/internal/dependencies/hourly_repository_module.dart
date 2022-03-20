import 'package:weather_app_2_0/data/repository/hour/hourly_data_repository.dart';
import 'package:weather_app_2_0/domain/repository/hour/hourly_repository.dart';

import 'api_module.dart';

class HourlyRepositoryModule {
  static HourlyRepository? _hourlyRepository;

  static HourlyRepository hourlyRepository() => _hourlyRepository ??= HourlyDataRepository(ApiModule.apiUtil());
}
