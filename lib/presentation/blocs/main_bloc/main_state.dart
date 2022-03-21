import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_2_0/domain/model/i_model.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object?> get props => [];
}

abstract class ContentState extends MainState {
  const ContentState();
}

class LoadingContentState extends ContentState {
  const LoadingContentState();
}

class LoadedContentState extends ContentState {
  const LoadedContentState({required this.content});

  final List<IModel> content;

  @override
  List<Object?> get props => [content];
}

class NotLoadedContentState extends ContentState {
  const NotLoadedContentState();
}

class UpdatedGeoPositionState extends MainState {
  const UpdatedGeoPositionState({
    required this.position,
    this.address,
  });

  final Position position;
  final String? address;

  @override
  List<Object?> get props => [position, address];
}
