import 'package:weather_app_2_0/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:weather_app_2_0/domain/use_cases/i_use_case.dart';
import 'package:weather_app_2_0/domain/model/hour/hour.dart';

class SetHourlyContent with IUseCase<bool, List<Hour>> {
  const SetHourlyContent({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<bool> execute({required List<Hour> params}) async {
    final bool deletingResult = await _localRepository.deleteHourlyContent();
    final bool settingResult = await _localRepository.setHourlyContent(content: params);
    return deletingResult && settingResult;
  }
}
