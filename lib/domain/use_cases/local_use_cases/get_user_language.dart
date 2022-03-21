import 'package:weather_app_2_0/domain/repositories/local_repositories/i_local_repository.dart';
import 'package:weather_app_2_0/domain/use_cases/i_use_case.dart';

class GetUserLanguage with IUseCase<String?, NoParams> {
  const GetUserLanguage({
    required ILocalRepository localRepository,
  }) : _localRepository = localRepository;

  final ILocalRepository _localRepository;

  // TODO:
  @override
  Future<String?> execute({NoParams params}) async => '';
  // _localRepository.getUserLanguage();
}
