import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dwyl_app/data/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit({required ImageRepository imageRepository}) : super(DataInitial(imageRepository));
}