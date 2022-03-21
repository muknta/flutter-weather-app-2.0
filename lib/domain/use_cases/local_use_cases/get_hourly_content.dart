import 'package:weather_app_2_0/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:weather_app_2_0/domain/use_cases/i_use_case.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';

class GetHourlyContent with IUseCase<List<Hour>, NoParams> {
  const GetHourlyContent({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<List<Hour>> execute({NoParams params}) => _localRepository.getHourlyContent();
}
