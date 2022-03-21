import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends MainEvent {
  const InitialEvent();
}

abstract class FetchDataEvent extends MainEvent {
  const FetchDataEvent();
}

class GetDailyEvent extends FetchDataEvent {
  const GetDailyEvent();
}

class GetHourlyEvent extends FetchDataEvent {
  const GetHourlyEvent();
}

class UpdateGeoPositionEvent extends MainEvent {
  const UpdateGeoPositionEvent();
}

class ChangeLanguageEvent extends MainEvent {
  const ChangeLanguageEvent({required this.chosenLanguageCode});

  final String chosenLanguageCode;

  @override
  List<Object> get props => [chosenLanguageCode];
}
