import 'package:injectable/injectable.dart';
import 'package:weather_app_2_0/domain/repositories/local_repositories/i_local_repository.dart';

@LazySingleton(as: ILocalRepository)
class LocalRepository implements ILocalRepository {}
