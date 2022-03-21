import 'package:weather_app_2_0/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:weather_app_2_0/domain/use_cases/i_use_case.dart';

class GetLanguage with IUseCase<String?, NoParams> {
  const GetLanguage({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  @override
  Future<String?> execute({NoParams params}) async => _localRepository.getLanguage();
}
