import 'package:weather_app_2_0/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:weather_app_2_0/domain/use_cases/i_use_case.dart';

class SetLanguage with IUseCase<bool, String> {
  const SetLanguage({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<bool> execute({required String params}) async => _localRepository.setLanguage(language: params);
}
