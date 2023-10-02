part of 'app_cubit.dart';

sealed class AppState extends Equatable {
  final bool isWeb;

  const AppState({required this.isWeb});

  @override
  List<Object> get props => [];
}

final class AppInitial extends AppState {
  const AppInitial({required super.isWeb});
}
