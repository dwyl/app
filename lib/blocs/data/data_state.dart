part of 'data_cubit.dart';

sealed class DataState extends Equatable {
  final ImageRepository imageRepository;

  const DataState(this.imageRepository);
}

final class DataInitial extends DataState {
  const DataInitial(super.imageRepository);

  @override
  List<Object> get props => [];
}
