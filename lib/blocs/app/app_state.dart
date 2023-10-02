part of 'app_cubit.dart';

sealed class AppState extends Equatable {
  final bool isWeb;

  const AppState({required this.isWeb});
}

final class AppInitial extends AppState {
  const AppInitial({required super.isWeb});

  @override
  List<Object> get props => [];
}
